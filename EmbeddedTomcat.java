import org.apache.catalina.Context;
import org.apache.catalina.LifecycleException;
import org.apache.catalina.startup.Tomcat;
import org.apache.catalina.WebResourceRoot;
import org.apache.catalina.webresources.DirResourceSet;
import org.apache.catalina.webresources.StandardRoot;

import java.io.File;

public class EmbeddedTomcat {
    public static void main(String[] args) throws LifecycleException {
        Tomcat tomcat = new Tomcat();
        tomcat.setPort(8080);
        
        String webappDirLocation = "src/main/webapp/";
        String contextPath = "";
        
        Context ctx = tomcat.addWebapp(contextPath, new File(webappDirLocation).getAbsolutePath());
        
        // Add compiled classes
        File additionWebInfClasses = new File("target/classes");
        WebResourceRoot resources = new StandardRoot(ctx);
        resources.addPreResources(new DirResourceSet(resources, "/WEB-INF/classes",
                additionWebInfClasses.getAbsolutePath(), "/"));
        ctx.setResources(resources);
        
        System.out.println("Starting server on http://localhost:8081");
        tomcat.start();
        tomcat.getServer().await();
    }
}
