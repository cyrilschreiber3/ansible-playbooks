import sys
import re
file = sys.argv[1]

def md_parser(file):
    # open the file and register each title line and its line number
    with open(file, 'r') as f:
        lines = f.readlines()
        titles = []
        for i, line in enumerate(lines):
            if line.startswith('#'):
                titles.append((i, line))
    return titles

def get_title_id(titles, title, parent_title):
    # check if the title exists multiple times
    title_line_ids = [i for i, t in titles if title in t]
    # if it exists multiple times, check if it has a parent title
    if len(title_line_ids) > 1:
        # if it has a parent title, get the id of the parent title
        if parent_title:
            parent_title_line_id = get_title_id(titles, parent_title, None)
            # return the id of the title with the parent title
            for i, title_line_id in enumerate(title_line_ids):
                if title_line_id > parent_title_line_id[0]:
                    return title_line_id, i
        # if it doesn't have a parent title, return the first id
        else:
            return title_line_ids[0], 0
    # if it exists only once, return the id
    elif len(title_line_ids) == 1:
        return title_line_ids[0], 0


def convert_link(link):
    link_params = {
        'link_text': link.split('|')[1],
        'filepath': f'/tmp/homelab-arch-public/{link.split("#")[0]}.md',
        'filename': link.split('#')[0] + '.md',
        'title': link.split('|')[0].split('#')[-1].rstrip("\\"),
        'parent_title': link.split('|')[0].split('#')[-2] if len(link.split('|')[0].split('#')) > 2 else None,
    }

    titles = md_parser(link_params['filepath'])
    title_id = get_title_id(titles, link_params['title'], link_params['parent_title'])

    link_params['title_hook'] = (link_params['title'].replace(' ', '-').lower()) + (f'-{title_id[1]}' if title_id[1] else "")

    final_link = f'[{link_params["link_text"]}]({link_params["filename"].replace(" ", "%20")}#{link_params["title_hook"]})'

    return final_link


def convert_all_links_in_file(file):
    with open(file, 'r') as f:
        content = f.read()
        links = re.findall(r'\[\[(.*?)\]\]', content)

        if not links:
            sys.exit(254)

        for link in links:
            converted_link = convert_link(link)
            content = content.replace(f"[[{link}]]", converted_link)

    with open(file, 'w') as f:
        f.write(content)

convert_all_links_in_file(file)