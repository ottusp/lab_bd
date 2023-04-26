import os

import pandas as pd


def main():
    raw_tables_paths = get_table_paths('raw_tables')
    clean_tables(raw_tables_paths)
    clean_tables_paths = get_table_paths('clean_tables')

    main_file = MainFile('load_scripts')

    for path in clean_tables_paths:
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


def clean_tables(raw_tables_paths):
    for table_path in raw_tables_paths:
        if '.csv' in table_path:
            df = pd.read_csv(table_path)
        else:
            df = pd.read_csv(table_path, delimiter='\t', header=0, encoding='UTF-8')

        df = df.replace('\\N', '')
        df = df.replace(to_replace="'", value="''", regex=True)

        file_name = table_path.split('/')[1]
        df.to_csv(f'clean_tables/{file_name}', index=False)


def get_table_paths(folder):
    # return [f'{folder}/cities.tsv']
    files = os.listdir(f'{folder}/')

    return [f'{folder}/{file}' for file in files]


def generate_update_statements_for_table(table_path, tablename):
    df = pd.read_csv(table_path)

    column_names = df.columns.tolist()
    column_string = ', '.join(column_names)

    statements = []
    for index, row in df.iterrows():
        values = clear_values(row)
        statements.append(f'INSERT INTO {tablename} ({column_string}) VALUES ({values})')

    return statements


def clear_values(row):
    def clear_row(cell):
        if pd.isna(cell):
            return "NULL"

        try:
            float(cell)
            return str(cell)
        except ValueError:
            pass

        return f"'{cell}'" if not str(cell).isdigit() else str(cell)

    return ', '.join(map(clear_row, row))


if __name__ == '__main__':
    main()
