package demo.greeting;

import static org.junit.Assert.assertTrue;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

import org.apache.commons.io.FileUtils;
import org.junit.BeforeClass;
import org.junit.Test;

import com.intuit.karate.cucumber.CucumberRunner;
import com.intuit.karate.cucumber.KarateStats;

import cucumber.api.CucumberOptions;
import demo.TestBase;

/**
 *
 * @author pthomas3
 */
@CucumberOptions(features = "classpath:demo/greeting/greeting.feature")
public class GreetingRunner extends TestBase {
	@BeforeClass
    public static void beforeClass() throws Exception {
        TestBase.beforeClass();
    }
	
	
    
    @Test
    public void testParallel() {
        String karateOutputPath = "target/surefire-reports";
        KarateStats stats = CucumberRunner.parallel(getClass(), 5, karateOutputPath);
        generateReport(karateOutputPath);
        assertTrue("there are scenario failures", stats.getFailCount() == 0);        
    }
    
	private static void generateReport(String karateOutputPath) {
		
		       
	    Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
	    @SuppressWarnings({ "unchecked", "rawtypes" })
		List<String> jsonPaths = new ArrayList(jsonFiles.size());
	    jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
	    Configuration config = new Configuration(new File("target"), "demo report");
	    ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
	    reportBuilder.generateReports();        
	} 
}
