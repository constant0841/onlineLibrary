package OnlineLibrary.User.Configuration;

import org.apache.catalina.connector.Connector;
import org.apache.coyote.http11.AbstractHttp11Protocol;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.servlet.server.ServletWebServerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class TomcatConfig {
    @Bean
    public ServletWebServerFactory servletContainer() {
        TomcatServletWebServerFactory factory = new TomcatServletWebServerFactory();

        factory.addConnectorCustomizers((Connector connector) -> {
            if (connector.getProtocolHandler() instanceof AbstractHttp11Protocol<?> protocolHandler) {
                protocolHandler.setMaxSwallowSize(-1); // 내부 제한 해제
                protocolHandler.setMaxHttpHeaderSize(65536);
            }
            connector.setMaxPostSize(-1); // POST 전체 크기 무제한
            connector.setProperty("maxParameterCount", "10000");
            connector.setProperty("maxFileCount", "10"); // 여기에만 남기기
        });

        return factory;
    }
}

