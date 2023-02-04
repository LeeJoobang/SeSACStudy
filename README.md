### Service Level Project

#### 요약

- 새싹 멤버들의 스터디 모임 매칭을 하는 기능을 가지고 있습니다. 개인의 휴대폰 번호 인증 후 회원가입을 진행합니다. 지도에서 스터디원을 찾고 있는 새싹을 확인할 수 있습니다. 

#### 개발기간

- `22. 11. 07. - 12. 07.

#### 고민과 해결

- 코드의 상세 내용이나, 불필요한 외부 노출을 명시적으로 제한하고자 접근 제어자 사용
- 회원가입 진행 시 반복되는 UI에 해당하는 뷰들을 CustomView로 생성해 재활용
- 회원가입 후 서버로부터 받아온 정보(email, FCMtoken, nick etc)를 여러 뷰에서 공용으로 사용하기 위해 Singleton Pattern 사용
