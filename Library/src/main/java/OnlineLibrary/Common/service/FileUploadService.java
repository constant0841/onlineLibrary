package OnlineLibrary.Common.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

@Service
public class FileUploadService {

    // application.properties에서 설정할 업로드 경로
    @Value("${file.upload.path:uploads/}")
    private String uploadPath;

    /**
     * 이미지 파일 업로드
     */
    public String uploadImage(MultipartFile file) throws IOException {
        if (file == null || file.isEmpty()) {
            return null;
        }

        // 파일 유효성 검사
        validateImageFile(file);

        // 날짜별 디렉토리 생성 (uploads/images/2025/07/08/)
        // 🔧 수정: DateTimeFormatter.ofPattern() 사용
        String dateDir = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
        String imagePath = uploadPath + "images/" + dateDir + "/";

        // 디렉토리 생성
        createDirectoryIfNotExists(imagePath);

        // 고유한 파일명 생성
        String originalName = file.getOriginalFilename();
        String extension = getFileExtension(originalName);
        String fileName = UUID.randomUUID().toString() + extension;

        // 파일 저장
        Path filePath = Paths.get(imagePath + fileName);
        Files.copy(file.getInputStream(), filePath);

        // 웹에서 접근할 수 있는 경로 반환
        return "/images/" + dateDir + "/" + fileName;
    }

    /**
     * PDF 파일 업로드
     */
    public String uploadPdf(MultipartFile file) throws IOException {
        if (file == null || file.isEmpty()) {
            return null;
        }

        validatePdfFile(file);

        // 🔧 수정: DateTimeFormatter.ofPattern() 사용
        String dateDir = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
        String pdfPath = uploadPath + "pdfs/" + dateDir + "/";

        createDirectoryIfNotExists(pdfPath);

        String originalName = file.getOriginalFilename();
        String extension = getFileExtension(originalName);
        String fileName = UUID.randomUUID().toString() + extension;

        Path filePath = Paths.get(pdfPath + fileName);
        Files.copy(file.getInputStream(), filePath);

        return "/pdfs/" + dateDir + "/" + fileName;
    }

    /**
     * 파일 삭제
     */
    public boolean deleteFile(String fileUrl) {
        if (fileUrl == null || fileUrl.isEmpty()) {
            return true;
        }

        try {
            // URL을 실제 파일 경로로 변환
            String filePath = uploadPath + fileUrl.substring(1); // 맨 앞의 '/' 제거
            File file = new File(filePath);

            if (file.exists()) {
                return file.delete();
            }
            return true;
        } catch (Exception e) {
            System.err.println("파일 삭제 실패: " + e.getMessage());
            return false;
        }
    }

    /**
     * 이미지 파일 유효성 검사
     */
    private void validateImageFile(MultipartFile file) {
        // 파일 크기 검사 (5MB)
        if (file.getSize() > 5 * 1024 * 1024) {
            throw new IllegalArgumentException("이미지 파일 크기는 5MB를 초과할 수 없습니다.");
        }

        // 파일 타입 검사
        String contentType = file.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            throw new IllegalArgumentException("이미지 파일만 업로드 가능합니다.");
        }

        // 확장자 검사
        String extension = getFileExtension(file.getOriginalFilename()).toLowerCase();
        if (!extension.matches("\\.(jpg|jpeg|png|gif|webp)$")) {
            throw new IllegalArgumentException("지원하지 않는 이미지 형식입니다. (jpg, png, gif, webp만 가능)");
        }
    }

    /**
     * PDF 파일 유효성 검사
     */
    private void validatePdfFile(MultipartFile file) {
        // 파일 크기 검사 (10MB)
        if (file.getSize() > 10 * 1024 * 1024) {
            throw new IllegalArgumentException("PDF 파일 크기는 10MB를 초과할 수 없습니다.");
        }

        // 파일 타입 검사
        String contentType = file.getContentType();
        if (!"application/pdf".equals(contentType)) {
            throw new IllegalArgumentException("PDF 파일만 업로드 가능합니다.");
        }

        // 확장자 검사
        String extension = getFileExtension(file.getOriginalFilename()).toLowerCase();
        if (!".pdf".equals(extension)) {
            throw new IllegalArgumentException("PDF 파일만 업로드 가능합니다.");
        }
    }

    /**
     * 디렉토리 생성
     */
    private void createDirectoryIfNotExists(String path) throws IOException {
        File directory = new File(path);
        if (!directory.exists()) {
            if (!directory.mkdirs()) {
                throw new IOException("디렉토리 생성에 실패했습니다: " + path);
            }
        }
    }

    /**
     * 파일 확장자 추출
     */
    private String getFileExtension(String fileName) {
        if (fileName == null || fileName.lastIndexOf(".") == -1) {
            return "";
        }
        return fileName.substring(fileName.lastIndexOf("."));
    }
}