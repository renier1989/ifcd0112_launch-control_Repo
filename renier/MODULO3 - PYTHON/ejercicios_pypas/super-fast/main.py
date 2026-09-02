def run(speed_km_h: float) -> float:
    # METROS = 1000
    # CENTIM = 100
    KM_CM = 100000
    SEGUNDOS_HORA = 3600
    speed_cm_s = speed_km_h * ( KM_CM / 1 ) * ( 1 / SEGUNDOS_HORA )
    # speed_cm_s = speed_km_h * ( METROS / 1 ) * ( CENTIM / 1 ) * ( 1 / SEGUNDOS_HORA )
    return int(speed_cm_s)


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
