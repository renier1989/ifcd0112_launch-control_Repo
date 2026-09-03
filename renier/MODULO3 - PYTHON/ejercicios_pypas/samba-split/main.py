def run(smb_path: str) -> tuple:
    clean = smb_path.strip('//')
    posi = clean.find('/')
    host = clean[:posi]
    path = clean[posi:]
    return host, path


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
