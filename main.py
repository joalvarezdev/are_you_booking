from webdriver_manager.chrome import ChromeDriverManager
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By

import time
import random
import configuration


def random_int() -> int:
    return random.randint(7, 10)


route = ChromeDriverManager(path="./chromedriver").install()

s = Service(route)

opt = webdriver.ChromeOptions()
# opt.add_argument("--headless")

driver = webdriver.Chrome(service=s, options=opt)


url = "https://qp.quickpassweb.com/pin/"

driver.get(url)

time.sleep(random_int())

driver.find_element(By.ID, "btnComenzar").click()

time.sleep(random_int())

# introducir ID de la pagina en ID=sensor_manual
driver.find_element(By.ID, "sensor_manual").send_keys(
        configuration.get_sensor_manual())

time.sleep(random_int())

# Luego presionar el boton validar Serial ID=btnReiniciar

driver.find_element(By.ID, "btnReiniciar").click()

time.sleep(3)

# completar Legajo ID=legajo

driver.find_element(By.ID, "legajo").send_keys(configuration.get_pin())

time.sleep(1)

# completar PIN ID=pin

driver.find_element(By.ID, "pin").send_keys(configuration.get_legajo())
time.sleep(3)

# presionar el boton fichar ID=btnFichar

driver.find_element(By.ID, "btnFichar").click()
time.sleep(3)

# Verificar el resultado en
