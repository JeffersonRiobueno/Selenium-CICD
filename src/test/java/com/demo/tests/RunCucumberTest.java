import org.junit.platform.suite.api.ConfigurationParameter;
import org.junit.platform.suite.api.SelectClasspathResource;
import org.junit.platform.suite.api.Suite;
import org.junit.platform.suite.api.SuiteDisplayName;
import io.cucumber.junit.platform.engine.Constants;

@Suite
@SuiteDisplayName("Run Cucumber Tests")
@SelectClasspathResource("features")
@ConfigurationParameter(key = Constants.PLUGIN_PROPERTY_NAME, value = "pretty, json:report/cucumber-report.json, html:report/cucumber-report.html")
@ConfigurationParameter(key = Constants.GLUE_PROPERTY_NAME, value = "com.demo.tests, steps")
public class RunCucumberTest {
}
