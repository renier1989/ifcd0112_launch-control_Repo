def run(feeling: str) -> str:
    feelingMin=feeling.lower()
    emojis = {
        "happy": "😀",
        "sad": "😔",
        "angry": "😡",
        "pensive": "🤔",
        "surprised": "😮"
    } 
    if feelingMin not in emojis:
        return None
    
    return emojis[feelingMin]


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
