CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
C   FFTPACK 5.0 
C
C   Authors:  Paul N. Swarztrauber and Richard A. Valent
C
C   $Id$
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC

      SUBROUTINE COSQ1F (N, INC, X, LENX, WSAVE, LENSAV, 
     1                   WORK, LENWRK, IER)
      INTEGER    N, INC, LENX, LENSAV, LENWRK, IER
      REAL       X(INC,*), WSAVE(LENSAV), WORK(LENWRK)
C
      IER = 0
C
      IF (LENX .LT. INC*(N-1) + 1) THEN
        IER = 1
        CALL XERFFT ('COSQ1F', 6)
        GO TO 300
      ELSEIF (LENSAV .LT. 2*N + INT(LOG(REAL(N))/LOG(2.)) +4) THEN
        IER = 2
        CALL XERFFT ('COSQ1F', 8)
        GO TO 300
      ELSEIF (LENWRK .LT. N) THEN
        IER = 3
        CALL XERFFT ('COSQ1F', 10)
        GO TO 300
      ENDIF
C
      IF (N-2) 102,101,103
  101 SSQRT2 = 1./SQRT(2.)
      TSQX = SSQRT2*X(1,2)
      X(1,2) = .5*X(1,1)-TSQX
      X(1,1) = .5*X(1,1)+TSQX
  102 RETURN
  103 CALL COSQF1 (N,INC,X,WSAVE,WORK,IER1)
      IF (IER1 .NE. 0) THEN
        IER = 20
        CALL XERFFT ('COSQ1F',-5)
      ENDIF
C
  300 CONTINUE
      RETURN
      END

