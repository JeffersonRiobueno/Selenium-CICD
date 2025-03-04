package com.demo.tests;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.cucumber.java.Scenario;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.junit.jupiter.api.Assertions;

public class GoogleSearchSteps {
    WebDriver driver;
    private Scenario scenario;

    @Before
    public void setUp(Scenario scenario) {
        this.scenario = scenario;
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--headless"); // Ejecutar sin UI
        options.addArguments("--disable-gpu");
        options.addArguments("--no-sandbox");

        driver = new ChromeDriver(options);
    }

    @Given("El usuario abre Google")
    public void el_usuario_abre_google() {
        driver.get("https://www.google.com");
        takeScreenshot(); // Captura de pantalla después de abrir Google
    }

    @Then("La página de Google carga correctamente")
    public void la_pagina_de_google_carga_correctamente() {
        Assertions.assertTrue(driver.getTitle().contains("Google"),
                "El título de la página no contiene 'Google'");
        takeScreenshot(); // Captura de pantalla después de verificar el título
    }

    @After
    public void tearDown() {
        if (driver != null) {
            driver.quit();
        }
    }

    private void takeScreenshot() {
        if (scenario.isFailed()) {
            // Si el escenario falla, se toma una captura de pantalla
            final byte[] screenshot = ((TakesScreenshot) driver).getScreenshotAs(OutputType.BYTES);
            scenario.attach(screenshot, "image/png", scenario.getName());
        } else {
            // Captura de pantalla en cada paso exitoso
            final byte[] screenshot = ((TakesScreenshot) driver).getScreenshotAs(OutputType.BYTES);
            scenario.attach(screenshot, "image/png", scenario.getName());
        }
    }
}