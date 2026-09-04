import os

import pytest

if os.path.exists('solution.py'):
    import solution as main
else:
    import main  # type:ignore

testdata = [
    ('ordenador', 36),
    ('TECLADO', 21),
    ('pantalla', 24),
    ('MONITOR', 21),
    ('procesador', 40),
    ('ImpresorA', 36),
]


@pytest.mark.parametrize('text, expected', testdata)
def test_run(text, expected):
    assert main.run(text) == expected
