import os

import pandas as pd


def main():
    table_paths = get_table_paths()
    main_file = MainFile('load_scripts')

    for path in table_paths:
        tablename = path.split('/')[1].split('.csv')[0]

        script = generate_update_statements_for_table(path, tablename)
        main_file.add_script(script, tablename)

    main_file.save()


class MainFile:
    def __init__(self, folder):
        self.folder = folder

    def add_script(self, script, tablename):
        with open(f'{self.folder}/{tablename}.sql', 'w') as file:
            for statement in script:
                file.write(f'{statement};\n')

    def save(self):
        pass


def get_table_paths():
    # return ['tables/status.csv']
    files = os.listdir('tables/')

    return [f'tables/{file}' for file in files]


def generate_update_statements_for_table(table_path, tablename):
    df = pd.read_csv(table_path)

    column_names = df.columns.tolist()
    column_string = ', '.join(column_names)

    statements = []
    for index, row in df.iterrows():
        a = lambda string: f'"{string}"' if not str(string).isdigit() else str(string)
        values = ', '.join(map(a, row))
        statements.append(f'INSERT INTO {tablename} ({column_string}) VALUES ({values})')

    return statements


if __name__ == '__main__':
    main()
