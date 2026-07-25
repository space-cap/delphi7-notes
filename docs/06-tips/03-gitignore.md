# 06-3. 필수 `.gitignore` 설정 및 파일 관리 🚫

> 💡 **초초보자를 위한 한 줄 요약**  
> 델파이가 알아서 만들어내는 쓰레기/임시 파일들(`.dcu`, `.~pas` 등)을 **깃(Git)에 올리지 않게 막아주는 거름망 설정**입니다!

---

## 🗑️ 깃에 올라가면 안 되는 델파이 임시 파일 목록

* **`*.dcu`**: 컴파일 중간 찌꺼기 파일 (누구 컴퓨터에서나 다시 생김)
* **`*.~*` (`.~pas`, `.~dfm`, `.~dpr`)**: 델파이가 이전 버전으로 복구하려고 만들어둔 **백업 임시 파일**
* **`*.exe`, `*.dll`**: 최종 결과물 바이너리 파일
* **`*.stat`, `*.local`, `*.identcache`**: IDE 개인 옵션/캐시 파일

---

## 📄 델파이 7 표준 `.gitignore` 예시 파일

프로젝트 루트 폴더에 `.gitignore` 파일을 만들고 아래 내용을 적어두세요!

```text
# Delphi 7 Build Artifacts
*.dcu
*.~*
*.exe
*.dll
*.bpl
*.dcp

# IDE User Options & Desktop settings
*.stat
*.local
*.identcache
*.dof
*.cfg
```

---

* **이전 단계**: [06-2. 자주 쓰는 IDE 단축키 및 디버깅 팁](02-shortcuts.md)
* **다음 단계**: [07-1. TADOConnection 및 TADOQuery 기초](../07-database/01-ado-basics.md)
