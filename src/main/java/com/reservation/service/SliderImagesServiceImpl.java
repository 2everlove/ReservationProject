package com.reservation.service;

import java.awt.print.PageFormat;
import java.awt.print.Pageable;
import java.awt.print.Printable;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.function.Function;
import java.util.stream.Collectors;

import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.reservation.dto.PageRequestDTO;
import com.reservation.dto.SliderImagesDTO;
import com.reservation.entity.Sliderimages;
import com.reservation.repository.SliderImagesRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
@RequiredArgsConstructor
public class SliderImagesServiceImpl implements SliderImagesService {
	
	private final SliderImagesRepository sliderImagesRepository;

	@Transactional
	@Override
	public SliderImagesDTO registerSliderImages(SliderImagesDTO dto) {
		System.out.println("registerSliderImages: "+dto);
		Sliderimages entity = dtoToEntity(dto);
		sliderImagesRepository.save(entity);
		System.out.println("registerSliderImages: "+entity);
		return entityToDTO(entity);
	}

	@Override
	public List<SliderImagesDTO> getSlideListForUser(String deleteFlg, String activity, String role) {
		Function<Sliderimages, SliderImagesDTO> fn = (entity -> entityToDTO(entity));
		List<Sliderimages> entity = new ArrayList<Sliderimages>();
		if(role.equals("user")) {
			entity = sliderImagesRepository.getSlideListForUser(deleteFlg, activity);
		} else if(role.equals("admin")){
			entity = sliderImagesRepository.getSlideListForAdmin();
		}
		return entity.stream().map(fn).collect(Collectors.toList());
	}

	@Override
	public int updateDelteFlg(SliderImagesDTO dto) {
		return sliderImagesRepository.updateDeleteFlg(dto.getDeleteFlg(), dto.getNo());
	}

	@Override
	public int updateActivation(SliderImagesDTO dto) {
		return sliderImagesRepository.updateActiveFlg(dto.getActivity(), dto.getNo());
	}

	@Transactional
	@Override
	public SliderImagesDTO modifySliderImages(SliderImagesDTO dto) {
		Sliderimages entity = sliderImagesRepository.findById(dto.getNo()).get();
		System.out.println("modifySliderImages: "+dto);
		if(dto.getActivity() != null)
			entity.setActivity(dto.getActivity());
		if(dto.getDeleteFlg() != null)
			entity.setDeleteFlg(dto.getDeleteFlg());
		if(dto.getFilename() != null)
			entity.setFilename(dto.getFilename());
		if(dto.getSortNo() != null)
			entity.setSortNo(dto.getSortNo());
		
		sliderImagesRepository.save(entity);
		
		return entityToDTO(entity);
	}
	
	


	
	

}
