# My_Portfolio
<h2> MyBatis를 사용한 웹 사이트 </h2>
설명 : 게시물을 작성구현, (제목 + 내용, 제목, 작성자)로 나누어 검색 기능 구현, 페이지 네비게이션 구현, 각 게시물에 대한 댓글 및 대댓글, 수정 삭제 기능 구현
회원관리 및 회원 가입과 세션 관리 등으로 웹 사이트를 구현하였다. 데이터베이스로는 (회원, 게시판, 댓글) 이렇게 3개를 가지고 있다. <br>

Spring + MyBatis + RDBMS 조합으로 구성하였고 MyBatis를 코드의 효율성이 향상되어 JDBC를 구현하였을때 보다 효율적으로 사용이 가능하다. 반복처리 코드 없이 간결하게 사용이 가능하여 코드의 양이 줄어든다.<br>
TDD를 여러번 사용하여 DAO, DTO 작성 후 테스트, Service 작성 후 테스트, 컨트롤러 작성 후 테스트, 마지막으로 jsp(뷰) 작성 후 테스트를 하여 안정적으로 개발할 수 있고 재설계 시간과 디버깅 시간, 추가 구현이 용이하게 해주는 등 많은 장점이 있다.<br>
Ajax를 사용하여 전체화면이 아닌 댓글만 업데이트가 가능하도록 하여 성능을 향상시켰다. <br>
<h4>느낀점 : 웹사이트를 어떻게 만들고 데이터베이스와 어떻게 연동하는지, 뷰(jsp)와 컨트롤러 계층의 연결 등 전체적인 부분을 익숙하게 익힐 수 있어 유익한 시간이었으며 전체적인 웹사이트들이 어떻게 이루어져있는지를 알 수 있는 시간이었다. </h4>

포트폴리오를 만들며 배운 것들 : 
• HTTP 요청과 응답 <br>
• 관심사의 분리와 MVC패턴 <br>
• @RequestMapping <br>
• @GetMapping <br>
• Spring DI <br>
• 워크벤치 사용법과 SQL기초 <br>
• Spring으로 DB 연결하기 <br>
• DAO의 작성과 적용 <br>
• AOP의 개념과 용어 <br>
• HTML과 CSS, JS(Jquery) 사용 <br>
• 서비스 계층의 분리와 @Transactional <br>
• MyBatis로 DAO작성하기 <br>
• 게시판 목록 만들기와 페이징 <br>
• 게시판 읽기 · 쓰기 · 삭제 · 수정 기능 구현 <br>
• REST API와 Ajax <br>
• 웹 프로젝트 기획 <br>
• git의 기본 명령어와 원리 <br>