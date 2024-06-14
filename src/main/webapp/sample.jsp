<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>sample</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<style type="text/css"></style>
</head>
<body>
	<div class="container-fluid bg-body-secondary">
		<!-- Content here -->
		<div class="row">
			<div class="col-12 bg-body-secondary">
				<!-- 최상단 -->
				<div class="row">
					<div class="col-10 bg-dark-subtle mx-1 my-1">SIN-SA</div>
					<div class="col bg-dark-subtle mx-1 my-1">
						<div class="row">
							<div class="col bg-dark-subtle mx-1 my-1">
								<a href="#"> 로그인 </a>
							</div>
							<div class="col bg-dark-subtle mx-1 my-1">
								<a href="#"> 회원가입 </a>
							</div>
						</div>
					</div>
				</div>
				<!-- 최상단 -->

				<!-- 콘텐츠 -->
				<div class="row">
					<!-- 좌측 사이드 -->
					<div class="col-2 bg-danger mx-1 my-1">
						categoty
						<ul>
							<li>ADIDAS</li>
							<li>FILA</li>
							<li>ASICS</li>
							<li>NIKE</li>
							<li>NEW BALANCE</li>
						</ul>
					</div>
					<!-- 좌측 사이드 -->

					<!-- 메인콘텐츠 -->
					<div class="col bg-warning mx-1 my-1">
						<div class="row">
							<div class="col bg-dark-subtle mx-1 my-1">
								<div id="carouselExampleCaptions" class="carousel slide">
									<div class="carousel-indicators">
										<button type="button"
											data-bs-target="#carouselExampleCaptions"
											data-bs-slide-to="0" class="" aria-label="Slide 1"></button>
										<button type="button"
											data-bs-target="#carouselExampleCaptions"
											data-bs-slide-to="1" aria-label="Slide 2" class=""></button>
										<button type="button"
											data-bs-target="#carouselExampleCaptions"
											data-bs-slide-to="2" aria-label="Slide 3" class="active"
											aria-current="true"></button>
									</div>
									<div class="carousel-inner">
										<div class="carousel-item">
											<svg
												class="bd-placeholder-img bd-placeholder-img-lg d-block w-100"
												width="800" height="400" xmlns="http://www.w3.org/2000/svg"
												role="img" aria-label="Placeholder: First slide"
												preserveAspectRatio="xMidYMid slice" focusable="false">
												<title>Placeholder</title><rect width="100%" height="100%"
													fill="#777"></rect>
												<text x="50%" y="50%" fill="#555" dy=".3em">First slide</text></svg>
											<div class="carousel-caption d-none d-md-block">
												<h5>First slide label</h5>
												<p>Some representative placeholder content for the first
													slide.</p>
											</div>
										</div>
										<div class="carousel-item">
											<svg
												class="bd-placeholder-img bd-placeholder-img-lg d-block w-100"
												width="800" height="400" xmlns="http://www.w3.org/2000/svg"
												role="img" aria-label="Placeholder: Second slide"
												preserveAspectRatio="xMidYMid slice" focusable="false">
												<title>Placeholder</title><rect width="100%" height="100%"
													fill="#666"></rect>
												<text x="50%" y="50%" fill="#444" dy=".3em">Second slide</text></svg>
											<div class="carousel-caption d-none d-md-block">
												<h5>Second slide label</h5>
												<p>Some representative placeholder content for the
													second slide.</p>
											</div>
										</div>
										<div class="carousel-item active">
											<svg
												class="bd-placeholder-img bd-placeholder-img-lg d-block w-100"
												width="800" height="400" xmlns="http://www.w3.org/2000/svg"
												role="img" aria-label="Placeholder: Third slide"
												preserveAspectRatio="xMidYMid slice" focusable="false">
												<title>Placeholder</title><rect width="100%" height="100%"
													fill="#555"></rect>
												<text x="50%" y="50%" fill="#333" dy=".3em">Third slide</text></svg>
											<div class="carousel-caption d-none d-md-block">
												<h5>Third slide label</h5>
												<p>Some representative placeholder content for the third
													slide.</p>
											</div>
										</div>
									</div>
									<button class="carousel-control-prev" type="button"
										data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
										<span class="carousel-control-prev-icon" aria-hidden="true"></span>
										<span class="visually-hidden">Previous</span>
									</button>
									<button class="carousel-control-next" type="button"
										data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
										<span class="carousel-control-next-icon" aria-hidden="true"></span>
										<span class="visually-hidden">Next</span>
									</button>
								</div>



							</div>
						</div>
						<div class="row">
							<div class="col bg-dark-subtle mx-1 my-1">
								<div class="row">
									<div class="col bg-info mx-1 my-1">top-left</div>
									<div class="col bg-info mx-1 my-1">top-center</div>
									<div class="col bg-info mx-1 my-1">top-right</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col bg-dark-subtle mx-1 my-1">
								<div class="row">
									<div class="col bg-info mx-1 my-1">center-left</div>
									<div class="col bg-info mx-1 my-1">center-center</div>
									<div class="col bg-info mx-1 my-1">center-right</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col bg-dark-subtle mx-1 my-1">
								<div class="row">
									<div class="col bg-info mx-1 my-1">bottom-left</div>
									<div class="col bg-info mx-1 my-1">bottom-center</div>
									<div class="col bg-info mx-1 my-1">bottom-right</div>
								</div>
							</div>
						</div>
					</div>
					<!-- 메인콘텐츠 -->

					<!--  우측 사이드 -->
					<div class="col-1 bg-danger mx-1 my-1">right-side</div>
					<!-- 우측 사이드 -->


				</div>
				<!-- 콘텐츠 -->



				<!-- 최하단 -->
				<div class="row">
					<div class="col bg-dark-subtle mx-1 my-1">bottom</div>
				</div>
			</div>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
		integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
		integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
		crossorigin="anonymous"></script>
</body>
</html>