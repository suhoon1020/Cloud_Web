    <%@ page import="cloud.UserDAO, cloud.DBConnection, cloud.User" %>
    <%@ page contentType="text/html; charset=UTF-8" %>
    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {

            request.setCharacterEncoding("UTF-8");

            // 입력 값 가져오기
            String userId = request.getParameter("userId");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");

            UserDAO userDAO = new UserDAO(DBConnection.getConnection());

            // DAO로 id조회
            User user = userDAO.getUserByUserId(userId);

            if (user == null || !user.getEmail().equals(email) || !user.getPhone().equals(phone)) {
                out.println("<script>alert('조회한 계정이 존재하지 않습니다.'); location.href='/Cloud_Web/login/foundPw.jsp';</script>");
            }
            else{
            // 세션에 userId 저장
            session.setAttribute("foundpw_userId", userId);
            response.sendRedirect("/Cloud_Web/login/resetPw.jsp");
            }
        }
    %>

        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>비밀번호 찾기</title>
            <link rel="stylesheet" href="/Cloud_Web/styles/signup_styles.css">
                <script>
        function validateForm() {
                    // 기존 에러 메시지 초기화
                    document.querySelectorAll(".error-msg").forEach(el => {
                        el.classList.remove("visible");
                    });
                    
                    const phonePattern = /^010-[0-9]{4}-[0-9]{4}$/;
                    const phone = document.getElementById("phone").value;

                    let isValid = true;

                    // 전화번호 검증
                    if (!phonePattern.test(phone)) {
                        const errorEl = document.getElementById("phoneError");
                        errorEl.textContent = "전화번호는 010-XXXX-XXXX 형식으로 입력해주세요.";
                        errorEl.classList.add("visible");
                        isValid = false;
                    }

                    return isValid; // 모든 검증 통과 시 제출
                }
        </script>
        </head>

        <body>
            <%@ include file = "/Cloud_Web/default.jsp" %>
            
                <section class="signupSection">
                <form class="signupForm" method="post" id="signup_form" onsubmit="return validateForm()">
                    <table>
                        <caption>비밀번호 찾기</caption>
                        <tr>
                            <td><label>아이디</label></td>
                            <td>
                                <input type="text" id="userId" name="userId" placeholder="아이디" value="" required>
                            </td>
                        </tr>
                        <tr>
                            <td><label>이메일</label></td>
                            <td>
                                <input type="email" id="email" name="email" placeholder="이메일" value="" required>
                            </td>
                        </tr>
                        <tr>
                            <td><label>전화번호</label></td>
                            <td>
                                <input type="tel" id="phone" name="phone" placeholder="010-1234-5678" value="" required>
                                <div id="phoneError" class="error-msg" style="color: red;"></div>
                            </td>
                        </tr>
                    </table>
                    <button type="submit" class="submitBtn">비밀번호 찾기</button>

                </form>
                </section>

            
        </body>
        
        </html>