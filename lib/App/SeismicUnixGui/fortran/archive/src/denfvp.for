	SUBROUTINE DENFVP(VP,D,IOP)
C
C COMPUTES DENSITY D (GR/CC) FROM P-WAVE VELOCITY VP (KM/SEC)
C
C IOP=1 : D=1.74*VP**0.25 ,GARDNER ET AL.,GEOPHYSICS 39,P 770-780,1974
C
C IOP=2 : D=1.85+0.165*VP ,CHRISTENSEN AND SHAW, GEOPHYS.J.R.ASTR.SOC
C                          20,P 271-284,1970. FOR BASALTIC SAMPLES AT
C                          1 KBAR.
C
C IOP=3 : NAFE AND DRAKE, THE SEA, VOL.4,PART 1,WILEY-INTERSCIENCES,NEW
C         YORK,1970.
C
	IF(IOP.EQ.1) THEN
	D=1.74*VP**0.25
	RETURN
	ENDIF
C
	IF(IOP.EQ.2) THEN
	D=1.85+0.165*VP
	RETURN
	ENDIF
C
	IF(IOP.EQ.3) THEN
C
		IF(VP.LT.1.7) THEN
		D=0.05+VP
		RETURN
		ENDIF
C
		IF(VP.LT.2.2) THEN
		D=1.75+0.5*(VP-1.7)
		RETURN
		ENDIF
C
		IF(VP.LT.3.2) THEN
		D=2.0 +0.25*(VP-2.2)
		RETURN
		ENDIF
C
		IF(VP.LT.6.2) THEN
		D=2.25+(VP-3.2)/6.0
		RETURN
		ENDIF
C
		IF(VP.LT.7.2) THEN
		D=2.75+0.25*(VP-6.2)
		RETURN
		ENDIF
C
		IF(VP.LT.8.6) THEN
		D=3.0 +(VP-7.2)/2.8
		RETURN
		ENDIF
C
		IF(VP.GE.8.6) THEN
		D=3.5 +(VP-8.6)/2.6
		RETURN
		ENDIF
C
	ENDIF
	RETURN
        END
