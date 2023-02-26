  function check_input()
   {
      if (!document.member_form.id.value) {
          alert("아이디를 입력하세요!");    
          document.member_form.id.focus();
          return false;
      }

      if (!document.member_form.passwd.value) {
          alert("비밀번호를 입력하세요!");    
          document.member_form.passwd.focus();
          return false;
      }

      if (!document.member_form.pass_confirm.value) {
          alert("비밀번호확인을 입력하세요!");    
          document.member_form.pass_confirm.focus();
          return;
      }

      if (!document.member_form.name.value) {
          alert("이름을 입력하세요!");    
          document.member_form.name.focus();
          return;
      }

      if (document.member_form.passwd.value != 
            document.member_form.pass_confirm.value) {
          alert("비밀번호가 일치하지 않습니다.\n다시 입력해 주세요!");
          document.member_form.passwd.focus();
          document.member_form.passwd.select();
          return;
      }

      document.member_form.submit();
   }

   function reset_form() {
      document.member_form.id.value = "";  
      document.member_form.passwd.value = "";
      document.member_form.pass_confirm.value = "";
      document.member_form.name.value = "";
      document.member_form.id.focus();
      return;
   }
   
   function check_id() {
	     window.open("memberCheckId.jsp?id=" + document.member_form.id.value,
	         		 "IDcheck",
	          		 "left=700,top=300,width=350,height=200,scrollbars=no,resizable=yes");
   }   
   