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
      subroutine valuesatinfinitys(inpc,textpart,physcon,
     &  istep,istat,n,iline,ipol,inl,ipoinp,inp,ipoinpc)
!
!     reading the input deck: *VALUES AT INFINITY
!
      implicit none
!
      character*1 inpc(*)
      character*132 textpart(16)
!
      integer i,istep,istat,n,key,iline,ipol,inl,ipoinp(2,*),inp(3,*),
     &  ipoinpc(0:*)
!
      real*8 physcon(*)
!
      if(istep.gt.0) then
         write(*,*) '*ERROR in valuesatinf: *VALUES AT INFINITY'
         write(*,*) '        should only be used before the first STEP'
         stop
      endif
!
      do i=2,n
         write(*,*) 
     &        '*WARNING in valuesatinf: parameter not recognized:'
         write(*,*) '         ',
     &        textpart(i)(1:index(textpart(i),' ')-1)
         call inputwarning(inpc,ipoinpc,iline,
     &"*VALUES AT INFINITY%")
      enddo
!
      call getnewline(inpc,textpart,istat,n,key,iline,ipol,inl,
     &     ipoinp,inp,ipoinpc)
!
      do i=1,5
         read(textpart(i),'(f20.0)',iostat=istat) physcon(3+i)
         if(istat.gt.0) call inputerror(inpc,ipoinpc,iline,
     &"*VALUES AT INFINITY%")
      enddo
!
      call getnewline(inpc,textpart,istat,n,key,iline,ipol,inl,
     &     ipoinp,inp,ipoinpc)
!
      return
      end







