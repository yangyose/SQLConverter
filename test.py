from sqllexer import SQLLexer

in_file = r'testdata\input.sql'
out_file = r'testdata\tokens.txt'

file = open(in_file, 'r')
sql_str = file.read()
file.close()

sqllexer = SQLLexer('oracle', sql_str)
sql_tokens = sqllexer.scan()

file = open(out_file, 'w')
for token in sql_tokens:
    file.write(token.ttype + ">>'" + token.tname + "'\n")
file.close()

print("end!")
