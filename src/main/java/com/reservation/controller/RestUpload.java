package com.reservation.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.List;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.reservation.dto.UploadResultDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Log4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/api")
public class RestUpload {
	
	private String uploadPath = "C://upload";
	
	@PostMapping("/removeFile")
	public ResponseEntity<Boolean> removeFile(String fileName){
		String srcFileName = null;
		System.out.println("removeFile: "+ fileName);
		try {
			List<String> tempfileNmae = Arrays.asList(fileName.split(","));
			tempfileNmae.forEach(i -> System.out.println(i));
			if(tempfileNmae.size() > 0) {
				boolean result = false;
				for(String fileNameFromList : tempfileNmae) {
					srcFileName = URLDecoder.decode(fileNameFromList,"UTF-8");
					File file = new File(uploadPath + File.separator +srcFileName);
					result = file.delete();
					File thumbnail = new File(file.getParent(),"s_"+file.getName());
					result = thumbnail.delete();
				}
				return new ResponseEntity<Boolean>(result,HttpStatus.OK);
			} else {
				srcFileName = URLDecoder.decode(fileName,"UTF-8");
				File file = new File(uploadPath + File.separator +srcFileName);
				boolean result = file.delete();
				File thumbnail = new File(file.getParent(),"s_"+file.getName());
				result = thumbnail.delete();
				return new ResponseEntity<Boolean>(result,HttpStatus.OK);
			}
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<Boolean>(false,HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	// method 추가
    @GetMapping("/download")
    public ResponseEntity<Resource> serveFile(@RequestParam(value="fileName") String srcFileName) {
    	try {
    		String fileName = URLDecoder.decode(srcFileName, "UTF-8");
            Path file = Paths.get(uploadPath).resolve(fileName);
            Resource resource = new UrlResource(file.toUri());
            if (resource.exists() || resource.isReadable()) {
            	Resource resourceFile = resource;
            	return ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION,
                        "attachment; fileName=\"" + resourceFile.getFilename() + "\"").body(resourceFile);
            }
            else {
                throw new RuntimeException("Could not read file: " + fileName);
            }
        }
        catch (MalformedURLException | UnsupportedEncodingException e) {
            throw new RuntimeException("Could not read file: " + srcFileName, e);
        }
    }
	
	/*@GetMapping("/display")
	public ResponseEntity<byte[]> getFile(String fileName){
		ResponseEntity<byte[]> result = null;
		try {
			String srcFileName = URLDecoder.decode(fileName, "UTF-8");
			log.info("fileName: "+srcFileName);
			File file = new File(uploadPath +File.separator+srcFileName);
			log.info("file: " + file);
			
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file),header,HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			log.info(e.getMessage());
			return new ResponseEntity<byte[]>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return result;
	}*/
    
	@GetMapping("/display")
	public ResponseEntity<Resource> getFile(String fileName){
		ResponseEntity<Resource> result = null;
		try {
			String srcFileName = URLDecoder.decode(fileName, "UTF-8");
			log.info("fileName: "+srcFileName);
			Resource file = new FileSystemResource(uploadPath +File.separator+srcFileName);
			//File file = new File(uploadPath +File.separator+srcFileName);
			log.info("file: " + file);
			
			if(!file.exists())
				return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
			
			HttpHeaders header = new HttpHeaders();
			Path filePath = Paths.get(uploadPath+File.separator+srcFileName);
			
			header.add("Content-Type", Files.probeContentType(filePath));
			result = new ResponseEntity<Resource>(file,header,HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			log.info(e.getMessage());
			return new ResponseEntity<Resource>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return result;
	}
	
	
	@PostMapping("/uploadAjax")
	public ResponseEntity<List<UploadResultDTO>> uploadFile(MultipartFile[] uploadFiles) throws NoSuchAlgorithmException {
		
		List<UploadResultDTO> resultDTOList = new ArrayList<UploadResultDTO>();
		log.info("uploadFile: "+uploadFiles.length);
		for(MultipartFile uploadFile : uploadFiles) {
			String originName = uploadFile.getOriginalFilename();
			String fileName = originName.substring(originName.lastIndexOf("\\") + 1);
			System.out.println("fileName: "+ fileName);
			String folderPath = makeFolder();
			
			String uuid = sha256ToString(fileName.toString()).substring(0, 32);
			
			String saveName = uploadPath + File.separator + folderPath + File.separator + uuid +"_"+fileName;
			
			Path savePath = Paths.get(saveName);
			
			try {
				uploadFile.transferTo(savePath.toFile());
				String thumbnailSaveName = uploadPath + File.separator + folderPath + File.separator + "s_"+uuid+"_"+fileName;
				
				File thumbnailFile = new File(thumbnailSaveName);
				
				Thumbnailator.createThumbnail(savePath.toFile(), thumbnailFile, 300, 300);
				
				resultDTOList.add(new UploadResultDTO(fileName, uuid, folderPath));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return new ResponseEntity<List<UploadResultDTO>>(resultDTOList, HttpStatus.OK);
		
	}//
	
	//makeFolder localDrive
	private String makeFolder() {
		String str = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
		
		String folderPath = str.replace("//", File.separator);
		
		File uploadPathFolder = new File(uploadPath, folderPath);
		
		if(uploadPathFolder.exists() == false) {
			uploadPathFolder.mkdirs();
		}
		return folderPath;
	}
	
	//sha-256 -> byte -> string
	public String sha256ToString(String msg) throws NoSuchAlgorithmException {
		SecureRandom random = SecureRandom.getInstance("SHA1PRNG");
		byte[] bytes1 = new byte[16];
		random.nextBytes(bytes1);
		String salt = new String(Base64.getEncoder().encode(bytes1));
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(salt.getBytes());
		md.update(msg.getBytes());
		byte[] bytes2 = md.digest();
	    StringBuilder sb = new StringBuilder();
	    for (byte b: bytes2) {
	    	sb.append(String.format("%02x", b));
	    }
	    for(int i = 1; i <= sb.length()/8; i++) {
			sb.insert(8*i, "-");
		}
		return sb.toString();
	}


	
	
}
