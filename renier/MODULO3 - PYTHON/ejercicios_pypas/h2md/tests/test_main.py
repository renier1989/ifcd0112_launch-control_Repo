import os

import pytest

if os.path.exists('solution.py'):
    import solution as main
else:
    import main  # type:ignore

testdata = [
    ('<h1>Core</h1>', '# Core'),
    ('<h2>Tipos de datos</h2>', '## Tipos de datos'),
    ('<h3>Cadenas de texto</h3>', '### Cadenas de texto'),
    ('<h4>Decoradores</h4>', '#### Decoradores'),
    ('<h5>Constructores</h5>', '##### Constructores'),
    ('<h6>hitos de la computación</h6>', '###### hitos de la computación'),
]


@pytest.mark.parametrize('html, expected', testdata)
def test_run(html, expected):
    assert main.run(html) == expected
