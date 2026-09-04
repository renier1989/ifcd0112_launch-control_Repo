def run(smb_path: str) -> tuple:
    posi = smb_path.find('/',3)
    host = smb_path[2:posi]
    path = smb_path[posi:]
    return host, path


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
