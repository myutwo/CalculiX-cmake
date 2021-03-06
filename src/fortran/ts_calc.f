!
!     CalculiX - A 3-dimensional finite element program
!     Copyright (C) 1998-2014 Guido Dhondt
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
      subroutine ts_calc(xflow,Tt,Pt,kappa,r,a,Ts,icase)
!     
!     this subroutine solves the implicit equation
!     f=xflow*dsqrt(Tt)/(a*Pt)-C*(TtdT)**expon*(Ttdt-1)**0.5d0
!
!     author: Yannick Muller
!     
      implicit none
!
      integer inv,icase,i
!     
      real*8 xflow,Tt,Pt,Ts,kappa,r,f,df,a,expon,Ts_old,C,TtzTs,
     &     deltaTs,TtzTs_crit, Qred_crit,Qred,h1,h2,h3
      expon=-0.5d0*(kappa+1.d0)/(kappa-1.d0)
!     
      C=dsqrt(2.d0/r*kappa/(kappa-1.d0))
!     
!     f=xflow*dsqrt(Tt)/(a*Pt)-C*(TtdT)**expon*(Ttdt-1)**0.5d0
!
!     df=-C*Ttdt**expon*(expon/Ts*(TtdT-1)**0.5d0
!     &     -0.5d0*TtdT/Ts*(TtdT-1.d0)**(-0.5d0))
!     
      Ts_old=Tt
!    
!
      if(xflow.lt.0d0) then 
         inv=-1
      else
         inv=1
      endif
!    
      if(dabs(xflow).le.1e-9) then
         Ts=Tt
         return
      endif
!
      Qred=abs(xflow)*dsqrt(Tt)/(a*Pt)
!
!     optimised estimate of T static
!
      Ts=Tt/(1+(Qred**2/C**2))
!     
!     adiabatic
!     
      if(icase.eq.0) then
!
         TtzTs_crit=(kappa+1.d0)/2.d0
!         
!     isothermal
!
      else
!
         TtzTs_crit=(1d0+(kappa-1.d0)/(2.d0*kappa))
!
      endif
!
      Qred_crit=C*(TtzTs_crit)**expon*(Ttzts_crit-1.d0)**0.5d0
!     
!      xflow_crit=inv*Qred_crit/dsqrt(Tt)*A*Pt
!     
      if(Qred.ge.Qred_crit) then
!     
         Ts=Tt/TtzTs_crit
!     
         return
!     
      endif
      i=0
!     
      do 
         i=i+1
         Ttzts=Tt/Ts
         h1=Ttzts-1.d0
         h2=dsqrt(h1)
         h3=Ttzts**expon
!     
         f=C*h2*h3
!     
         df=f*(expon+0.5d0*Ttzts/h1)/Ts
!
         f=Qred-f
         deltaTs=-f/df
!     
         Ts=Ts+deltaTs
!     
         if( (((dabs(Ts-Ts_old)/ts_old).le.1.E-8))
     &        .or.((dabs(Ts-Ts_old)).le.1.E-10)) then
            exit
         else if(i.gt.20) then
            Ts=0.9*Tt
            exit
         endif
         Ts_old=Ts
      enddo
!     
      return
      end
      
      
      
