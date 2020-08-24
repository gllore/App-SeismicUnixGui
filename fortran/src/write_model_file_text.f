      subroutine write_model_file_text(NL,VT,VB,DZ,VST,VSB,RHOT,RHOB,
     + outbound )
!      implicit none

      DIMENSION VT(*),VB(*),DZ(*),VST(*),VSB(*),RHOT(*),RHOB(*)
      character (len=300) :: outbound
      integer NL


!      integer :: result
!     print *, 'write_model_file_text, outbound is: ', outbound

C
C WRITES VELOCITY MODEL In a file
C
       ICH = 9
       open (unit=ICH,file=outbound,status='replace')

       WRITE(ICH,50)
       WRITE(ICH,100)
       WRITE(ICH,50)
C
       A1=0.
       A2=0.
       DO 20 I=1,NL
       A1=A1+DZ(I)
C COMPUTES 2-WAY TRAVELTIME ASSUMING EITHER CONSTANT VELOCITY OR
C CONSTANT VELOCITY GRADIENT LAYERS.
C
       IF(VT(I).EQ.VB(I)) THEN
              A2=A2+2.*DZ(I)/VT(I)
       ELSE
              A2=A2+2.*DZ(I)*ALOG(VB(I)/VT(I))/(VB(I)-VT(I))
       ENDIF
C
       WRITE(ICH,200) I,VT(I),VB(I),DZ(I),A1,A2,VST(I),VSB(I),
     +  RHOT(I),RHOB(I)
20     CONTINUE
       WRITE(ICH,50)
C
50     FORMAT('')
100    FORMAT(3X,'#',4X,'VTOP',3X,'VBOTT',6X,'DZ',3X,'ZBOTT',
     +  4X,'TWTT',3X,'VSTOP',2X,'VSBOTT',4X,'RHOT',4X,'RHOB')
200    FORMAT(I4,11F8.5)
C
!       RETURN

      close (ICH)

!      print *, 'result',result

      end subroutine write_model_file_text
