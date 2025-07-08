package OnlineLibrary.Common.configuration;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Value("${file.upload.path:uploads/}")
    private String uploadPath;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 업로드된 파일을 웹에서 접근할 수 있도록 설정
        registry.addResourceHandler("/images/**")
                .addResourceLocations("file:" + uploadPath + "images/");

        registry.addResourceHandler("/pdfs/**")
                .addResourceLocations("file:" + uploadPath + "pdfs/");
    }
}