import configparser


def get_sensor_manual() -> str:
    return config["CREDENTIALS"]["SENSOR_MANUAL"]


def get_legajo() -> str:
    return config["CREDENTIALS"]["LEGAJO"]


def get_pin() -> str:
    return config["CREDENTIALS"]["PIN"]


config = configparser.ConfigParser()
config.read("config.ini")
