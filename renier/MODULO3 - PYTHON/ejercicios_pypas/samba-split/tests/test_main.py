import os

import pytest

if os.path.exists('solution.py'):
    import solution as main
else:
    import main  # type:ignore

testdata = [
    ('//1.1.1.1/aprende/python', ('1.1.1.1', '/aprende/python')),
    ('//samba-server/psf/guido', ('samba-server', '/psf/guido')),
    ('//8.6.4.2/data/work/upload/', ('8.6.4.2', '/data/work/upload/')),
]


@pytest.mark.parametrize('smb_path, expected', testdata)
def test_run(smb_path, expected):
    assert main.run(smb_path) == expected
