from sqllexer  import SQLLexer
from sqlparser import SQLParser

in_file = r'testdata\input.sql'
out_file = r'testdata\tokens.txt'
sql_engine = 'oracle'

file = open(in_file, 'r')
sql_str = file.read()
file.close()

sqllexer = SQLLexer(sql_engine, sql_str)
sql_tokens = sqllexer.scan()
sqlparser = SQLParser(sql_engine, sql_tokens)
token_index = sqlparser.parse()

file = open(out_file, 'w')
for i in token_index:
    file.write(sql_tokens[i].ttype + ">>'" + sql_tokens[i].tname + "'\n")
file.close()


print("end!")
