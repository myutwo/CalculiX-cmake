!
!     CalculiX - A 3-dimensional finite element program
!              Copyright (C) 1998-2014 Guido Dhondt
!
!     This program is free software; you can redistribute it and/or
!     modify it under the terms of the GNU General Public License as
!     published by the Free Software Foundation(version 2);
!     
!
!     This program is distributed in the hope that it will be useful,
!     but WITHOUT ANY WARRANTY; without even the implied warranty of 
!     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
!     GNU General Public License for more details.
!
!     You should have received a copy of the GNU General Public License
!     along with this program; if not, write to the Free Software
!     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
!
!
!     author: Yannick Muller
!
      subroutine wpi(W, PI, Q, SQTT,kappa,RGAS)
!
!-----------------------------------------------------------------------
!                                                                      |
!     Dieses Unterprogramm berechnet die Stroemungs-Geschwindigkeit    |
!     fuer das eingegebene Druckverhaeltnis PI.                        |
!                                                                      |
!     Eingabe-Groessen:                                                |
!       PI     = Druckverhaeltnis PS/PT                                |
!       Q      = reduzierter Durchsatz                                 |
!       SQTT   = SQRT (Totaltemperatur)                                |
!                                                                      |
!     Ausgabe-Groessen:                                                |
!       W      = Stroemungs-Geschwindigkeit                            |
!                                                                      |
!-----------------------------------------------------------------------
!
      IMPLICIT CHARACTER*1 (A-Z)
!       INCLUDE 'comkapfk.inc'
      real*8    W, PI, Q, SQTT,kappaq,kappa,RGAS,pikrit,kappah,wkritf
!
!-----------------------------------------------------------------------
!
      kappaq = 1/kappa
      PIKRIT = (2./(KAPPA+1.)) ** (KAPPA/(KAPPA-1.))
!
      KAPPAH = 2. * KAPPA / (KAPPA + 1.)
      WKRITF = SQRT( KAPPAH * RGAS )
!
      IF (PI.GE.1.) THEN
!       Druckverhaeltnis groesser gleich 1
        W    = 0.
      ELSEIF (PI.GT.PIKRIT) THEN
!       Druckverhaeltnis unterkritisch
        IF (Q.GT.0.) THEN
          W    = Q * RGAS * SQTT * PI**(-KAPPAQ)
        ELSE
          W    = 0.
        ENDIF
      ELSEIF (PI.GT.0.) THEN
!       Druckverhaeltnis ueberkritisch
        W    = WKRITF * SQTT
      ELSE
!       Druckverhaeltnis ungueltig
        W    = 1.E20
      ENDIF
!
      RETURN
      END
      
      
      
