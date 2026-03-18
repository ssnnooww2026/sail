<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>회원가입</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

    body {
      font-family: 'Noto Sans KR', sans-serif;
      background: #f5f5f3;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 2rem 1rem;
    }

    .signup-wrap {
      width: 100%;
      max-width: 420px;
      background: #ffffff;
      border: 0.5px solid rgba(0,0,0,0.12);
      border-radius: 16px;
      padding: 2rem 2rem 2.5rem;
    }

    .signup-logo { text-align: center; margin-bottom: 1.8rem; }
    .signup-logo .logo-circle {
      width: 48px; height: 48px; border-radius: 50%;
      background: #1a1a1a; display: inline-flex;
      align-items: center; justify-content: center; margin-bottom: 0.75rem;
    }
    .signup-logo h1 { font-size: 18px; font-weight: 600; color: #1a1a1a; }
    .signup-logo p { font-size: 13px; color: #888; margin: 4px 0 0; }

    .field { margin-bottom: 1.1rem; }
    .field label { display: block; font-size: 13px; font-weight: 500; color: #555; margin-bottom: 6px; }
    .field input[type="text"], .field input[type="date"] {
      width: 100%; height: 42px; padding: 0 12px;
      font-family: inherit; font-size: 14px; color: #1a1a1a;
      background: #f9f9f7;
      border: 0.5px solid rgba(0,0,0,0.18);
      border-radius: 8px;
      outline: none; transition: border-color 0.15s, box-shadow 0.15s;
    }
    .field input[type="text"]:focus, .field input[type="date"]:focus {
      border-color: #1a1a1a;
      box-shadow: 0 0 0 3px rgba(0,0,0,0.08);
      background: #fff;
    }
    .field input.error { border-color: #e24b4a; }
    .field .hint { font-size: 12px; color: #aaa; margin-top: 4px; }
    .field .err-msg { font-size: 12px; color: #e24b4a; margin-top: 4px; display: none; }
    .field .err-msg.show { display: block; }

    .pw-wrap {
      position: relative; display: flex; align-items: center;
      height: 42px; background: #f9f9f7;
      border: 0.5px solid rgba(0,0,0,0.18);
      border-radius: 8px;
      transition: border-color 0.15s, box-shadow 0.15s;
      overflow: hidden;
    }
    .pw-wrap.focused {
      border-color: #1a1a1a;
      box-shadow: 0 0 0 3px rgba(0,0,0,0.08);
      background: #fff;
    }
    .pw-wrap.error { border-color: #e24b4a; }

    .pw-scroll-area {
      flex: 1; overflow-x: auto; overflow-y: hidden;
      white-space: nowrap; height: 100%;
      display: flex; align-items: center;
      padding: 0 8px 0 12px;
      scrollbar-width: none;
    }
    .pw-scroll-area::-webkit-scrollbar { display: none; }

    .pw-text {
      display: inline-block; white-space: nowrap;
      font-size: 20px; letter-spacing: 3px;
      color: #1a1a1a; line-height: 1; min-width: 1px;
    }
    .pw-text.show-mode { font-size: 14px; letter-spacing: 0; }
    .pw-text.placeholder { font-size: 14px; letter-spacing: 0; color: #bbb; }

    .pw-cursor {
      display: inline-block; width: 1.5px; height: 16px;
      background: #1a1a1a; margin-left: 1px;
      vertical-align: middle; animation: blink 1s step-end infinite; opacity: 0;
    }
    .pw-wrap.focused .pw-cursor { opacity: 1; }
    @keyframes blink { 0%,100%{opacity:1} 50%{opacity:0} }

    .pw-toggle {
      flex-shrink: 0; width: 36px; height: 100%;
      display: flex; align-items: center; justify-content: center;
      background: none; border: none;
      border-left: 0.5px solid rgba(0,0,0,0.1);
      cursor: pointer; color: #aaa;
    }
    .pw-toggle:hover { color: #555; background: #f0f0ee; }

    .hidden-input {
      position: absolute; opacity: 0; pointer-events: none; width: 0; height: 0;
    }

    .strength-bar { display: flex; gap: 4px; margin-top: 6px; }
    .strength-bar span {
      flex: 1; height: 3px; border-radius: 2px;
      background: #e0e0e0; transition: background 0.2s;
    }
    .strength-bar span.weak { background: #e24b4a; }
    .strength-bar span.medium { background: #ef9f27; }
    .strength-bar span.strong { background: #639922; }

    .submit-btn {
      width: 100%; height: 44px; margin-top: 0.5rem;
      background: #1a1a1a; color: #fff;
      font-family: inherit; font-size: 14px; font-weight: 500;
      border: none; border-radius: 8px;
      cursor: pointer; transition: opacity 0.15s, transform 0.1s;
    }
    .submit-btn:hover { opacity: 0.82; }
    .submit-btn:active { transform: scale(0.99); }

    .login-link { text-align: center; margin-top: 1rem; font-size: 13px; color: #888; }
    .login-link a { color: #1a1a1a; font-weight: 500; text-decoration: none; }
    .login-link a:hover { text-decoration: underline; }

    .success-box { display: none; text-align: center; padding: 2.5rem 1rem; }
    .success-box .check-icon {
      width: 56px; height: 56px; border-radius: 50%;
      background: #eaf3de; margin: 0 auto 1rem;
      display: flex; align-items: center; justify-content: center;
    }
    .success-box h2 { font-size: 18px; font-weight: 600; margin: 0 0 6px; color: #1a1a1a; }
    .success-box p { font-size: 14px; color: #888; margin: 0 0 1.5rem; }
    .success-box .back-btn {
      background: none; border: 0.5px solid rgba(0,0,0,0.18);
      border-radius: 8px; padding: 10px 24px;
      font-family: inherit; font-size: 13px; font-weight: 500;
      color: #1a1a1a; cursor: pointer;
    }
    .success-box .back-btn:hover { background: #f5f5f3; }

    .birthday-checking { font-size: 12px; color: #aaa; display: none; margin-top: 4px; }
  </style>
</head>
<body>

<div class="signup-wrap">
  <div id="formView">
    <div class="signup-logo">
      <div class="logo-circle">
        <svg viewBox="0 0 24 24" fill="none" width="24" height="24">
          <circle cx="12" cy="8" r="3.5" stroke="white" stroke-width="1.5"/>
          <path d="M5 20c0-4 3.134-7 7-7s7 3 7 7" stroke="white" stroke-width="1.5" stroke-linecap="round"/>
        </svg>
      </div>
      <h1>회원가입</h1>
      <p>정보를 입력하여 계정을 만드세요</p>
    </div>

    <div class="field">
      <label>이름</label>
      <input type="text" id="name" placeholder="홍길동" autocomplete="off" />
      <div class="err-msg" id="nameErr">이름을 입력해주세요.</div>
    </div>

    <div class="field">
      <label>아이디</label>
      <input type="text" id="userId" placeholder="영문·숫자 조합 4~20자" autocomplete="off" />
      <div class="hint">영문 소문자, 숫자, 밑줄(_)만 사용 가능해요.</div>
      <div class="err-msg" id="userIdErr">영문·숫자 조합 4자 이상 입력해주세요.</div>
    </div>

    <div class="field">
      <label>생년월일</label>
      <input type="date" id="birthday" onchange="checkBirthday()" />
      <div class="birthday-checking" id="birthdayChecking">확인 중...</div>
      <div class="err-msg" id="birthdayErr">생년월일을 선택해주세요.</div>
      <div class="err-msg" id="birthdayDupErr">이미 사용 중인 생년월일입니다.</div>
    </div>

    <div class="field">
      <label>비밀번호</label>
      <div class="pw-wrap" id="pw1Wrap" onclick="focusPw('pw1')">
        <input class="hidden-input" id="pw1" type="text" autocomplete="new-password" />
        <div class="pw-scroll-area" id="pw1Scroll">
          <span class="pw-text placeholder" id="pw1Text">8자 이상 입력해주세요</span>
          <span class="pw-cursor" id="pw1Cursor"></span>
        </div>
        <button class="pw-toggle" id="pw1Toggle" onclick="event.stopPropagation(); toggleShow('pw1')" type="button">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
            <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"/><line x1="1" y1="1" x2="23" y2="23"/>
          </svg>
        </button>
      </div>
      <div class="strength-bar">
        <span id="s1"></span><span id="s2"></span><span id="s3"></span><span id="s4"></span>
      </div>
      <div class="err-msg" id="passwordErr">비밀번호를 8자 이상 입력해주세요.</div>
    </div>

    <div class="field">
      <label>비밀번호 확인</label>
      <div class="pw-wrap" id="pw2Wrap" onclick="focusPw('pw2')">
        <input class="hidden-input" id="pw2" type="text" autocomplete="new-password" />
        <div class="pw-scroll-area" id="pw2Scroll">
          <span class="pw-text placeholder" id="pw2Text">비밀번호를 다시 입력해주세요</span>
          <span class="pw-cursor" id="pw2Cursor"></span>
        </div>
        <button class="pw-toggle" id="pw2Toggle" onclick="event.stopPropagation(); toggleShow('pw2')" type="button">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
            <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"/><line x1="1" y1="1" x2="23" y2="23"/>
          </svg>
        </button>
      </div>
      <div class="err-msg" id="passwordConfirmErr">비밀번호가 일치하지 않아요.</div>
    </div>

    <button class="submit-btn" onclick="handleSubmit()">가입하기</button>
    <div class="login-link">이미 계정이 있으신가요? <a href="#">로그인</a></div>
  </div>

  <div class="success-box" id="successView">
    <div class="check-icon">
      <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#639922" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
        <polyline points="20 6 9 17 4 12"/>
      </svg>
    </div>
    <h2>가입 완료!</h2>
    <p id="successMsg">환영합니다. 계정이 생성되었어요.</p>
    <button class="back-btn" onclick="resetForm()">처음으로 돌아가기</button>
  </div>
</div>

<script>
  const pwState = {
    pw1: { val: '', show: false, ph: '8자 이상 입력해주세요' },
    pw2: { val: '', show: false, ph: '비밀번호를 다시 입력해주세요' }
  };

  function renderPw(id) {
    const s = pwState[id];
    const textEl = document.getElementById(id + 'Text');
    const scrollEl = document.getElementById(id + 'Scroll');
    if (s.val.length === 0) {
      textEl.textContent = s.ph;
      textEl.className = 'pw-text placeholder';
    } else {
      textEl.textContent = s.show ? s.val : '●'.repeat(s.val.length);
      textEl.className = s.show ? 'pw-text show-mode' : 'pw-text';
    }
    requestAnimationFrame(() => { scrollEl.scrollLeft = scrollEl.scrollWidth; });
  }

  function focusPw(id) { document.getElementById(id).focus(); }

  function setupPw(id) {
    const input = document.getElementById(id);
    const wrap = document.getElementById(id + 'Wrap');
    input.addEventListener('focus', () => wrap.classList.add('focused'));
    input.addEventListener('blur', () => wrap.classList.remove('focused'));
    input.addEventListener('keydown', (e) => {
      if (e.key === 'Backspace') {
        pwState[id].val = pwState[id].val.slice(0, -1);
        renderPw(id);
        if (id === 'pw1') updateStrength();
        e.preventDefault();
      }
    });
    input.addEventListener('input', () => {
      const added = input.value;
      input.value = '';
      pwState[id].val += added;
      renderPw(id);
      if (id === 'pw1') updateStrength();
    });
    renderPw(id);
  }

  function toggleShow(id) {
    pwState[id].show = !pwState[id].show;
    const btn = document.getElementById(id + 'Toggle');
    btn.querySelector('svg').innerHTML = pwState[id].show
      ? '<path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/>'
      : '<path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"/><line x1="1" y1="1" x2="23" y2="23"/>';
    renderPw(id);
  }

  function updateStrength() {
    const v = pwState['pw1'].val;
    let score = 0;
    if (v.length >= 8) score++;
    if (/[A-Z]/.test(v) || /[a-z]/.test(v)) score++;
    if (/[0-9]/.test(v)) score++;
    if (/[^A-Za-z0-9]/.test(v)) score++;
    const cls = score <= 1 ? 'weak' : score <= 3 ? 'medium' : 'strong';
    for (let i = 1; i <= 4; i++) document.getElementById('s' + i).className = i <= score ? cls : '';
  }

  function checkBirthday() {
    const val = document.getElementById('birthday').value;
    if (!val) return;
    showErr('birthdayErr', false); showErr('birthdayDupErr', false);
    const checking = document.getElementById('birthdayChecking');
    checking.style.display = 'block';
    setTimeout(() => {
      checking.style.display = 'none';
      document.getElementById('birthday').classList.add('error');
      showErr('birthdayDupErr', true);
    }, 700);
  }

  function showErr(id, show) {
    const el = document.getElementById(id);
    el && (show ? el.classList.add('show') : el.classList.remove('show'));
  }

  function handleSubmit() {
    const name = document.getElementById('name').value.trim();
    const userId = document.getElementById('userId').value.trim();
    const birthday = document.getElementById('birthday').value;
    const password = pwState['pw1'].val;
    const passwordConfirm = pwState['pw2'].val;
    let valid = true;

    if (!name) { showErr('nameErr', true); valid = false; } else showErr('nameErr', false);
    if (!userId || userId.length < 4 || !/^[a-z0-9_]+$/.test(userId)) { showErr('userIdErr', true); valid = false; } else showErr('userIdErr', false);
    if (!birthday) { showErr('birthdayErr', true); showErr('birthdayDupErr', false); valid = false; }
    else { showErr('birthdayErr', false); showErr('birthdayDupErr', true); document.getElementById('birthday').classList.add('error'); valid = false; }
    if (!password || password.length < 8) { showErr('passwordErr', true); valid = false; } else showErr('passwordErr', false);
    if (password !== passwordConfirm) { showErr('passwordConfirmErr', true); valid = false; } else showErr('passwordConfirmErr', false);

    if (valid) {
      document.getElementById('successMsg').textContent = name + '님, 환영합니다! 계정이 생성되었어요.';
      document.getElementById('formView').style.display = 'none';
      document.getElementById('successView').style.display = 'block';
    }
  }

  function resetForm() {
    document.getElementById('formView').style.display = 'block';
    document.getElementById('successView').style.display = 'none';
    ['name','userId','birthday'].forEach(id => { document.getElementById(id).value = ''; document.getElementById(id).classList.remove('error'); });
    pwState.pw1.val = ''; pwState.pw2.val = '';
    pwState.pw1.show = false; pwState.pw2.show = false;
    renderPw('pw1'); renderPw('pw2');
    ['nameErr','userIdErr','birthdayErr','birthdayDupErr','passwordErr','passwordConfirmErr'].forEach(id => showErr(id, false));
    for (let i = 1; i <= 4; i++) document.getElementById('s'+i).className = '';
  }

  setupPw('pw1');
  setupPw('pw2');
</script>
</body>
</html>
