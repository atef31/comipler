import re

# Define token specification for C-Minus language
token_specification = [
    ('NUMBER',   r'\d+'),
    ('ID',       r'[a-zA-Z_]\w*'),
    ('ASSIGN',   r'='),
    ('SEMI',     r';'),
    ('LPAREN',   r'\('),
    ('RPAREN',   r'\)'),
    ('LBRACE',   r'\{'),
    ('RBRACE',   r'\}'),
    ('PLUS',     r'\+'),
    ('MINUS',    r'-'),
    ('MULT',     r'\*'),
    ('DIV',      r'/'),
    ('LT',       r'<'),
    ('GT',       r'>'),
    ('LE',       r'<='),
    ('GE',       r'>='),
    ('EQ',       r'=='),
    ('NE',       r'!='),
    ('WHILE',    r'while'),
    ('IF',       r'if'),
    ('ELSE',     r'else'),
    ('INT',      r'int'),
    ('RETURN',   r'return'),
    ('VOID',     r'void'),
    ('NEWLINE',  r'\n'),
    ('SKIP',     r'[ \t]+'),
    ('MISMATCH', r'.'),  # Any other character
]

token_regex = '|'.join(f'(?P<{name}>{regex})' for name, regex in token_specification)

def lex(code):
    tokens = []
    for mo in re.finditer(token_regex, code):
        kind = mo.lastgroup
        value = mo.group()
        if kind == 'NUMBER':
            value = int(value)
        elif kind == 'ID':
            if value in ['if', 'else', 'while', 'int', 'return', 'void']:
                kind = value.upper()
        elif kind == 'SKIP' or kind == 'NEWLINE':
            continue
        elif kind == 'MISMATCH':
            raise RuntimeError(f'Unexpected character {value!r}')
        tokens.append((kind, value))
    return tokens


# Test code
if __name__ == "__main__":
    code = '''
    int x;
    x = 5;
    if (x > 0) {
        x = x - 1;
    }
    '''
    result = lex(code)
    for token in result:
        print(token)
