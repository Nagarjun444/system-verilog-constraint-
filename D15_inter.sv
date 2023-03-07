//generate odd number/even number ina fixed size array using $rando

/*class obj;
  
reg [4:0] data;
 function odd_even(input data);
  begin 
    if(data%2==0)
	 $display("is even number");
	else
	  $display("is odd number");
	end
endfunction


endclass




module odd();
obj obj2;
reg [5:0] i;
initial
 begin
 obj2=new();
 
  for( i=0;i<=10;i=i+1)
    begin
      obj2.data=$random;
	   $display("number",obj2.data);
	   obj2.odd_even(obj2.data);
   end
 end

endmodule*/


////method2

//****genreate odd values & Even values also  only**********//

/*module test;
  bit [4:0] a[10];
  initial begin
    foreach(a[i])
      begin
        a[i] = $random;
        $display(" default a[i]=%0d",a[i]);    // by default value printing 
        if(a[i]%2==0)                  // to get even values here 
          begin
            a[i]=a[i]+1;  //after geeting even adding +1 here to genrate odd values // uncoment so will print both even and odd values here 
            $display("array of odd values : %p",a);
         end
        else
            $display("array : %p",a);
      end
  end
endmodule*/

//****genreate even values only**********
/*
module test;
  bit [3:0] a[6];
  initial begin
    foreach(a[i])
      begin
        a[i] = $random;
        $display("a[i]=%0d",a[i]);  // by default value printing 
        if(a[i]%2==0)              // to get even values here 
          $display("array : %p",a);
        else
        
         	a[i]=a[i]+1;
            $display("array of even values : %p",a);
    
      end
  end
endmodule

*/

/*

//---Write a constraint for 2D fixed size array randomization using Dynamic array ?
class fs_array;
   rand bit [7:0] array1[6][5];
   
   constraint array_c {foreach(array1[i,j])
                        array1[i][j]==i+j;}
						
	
  function void display();
    $display("array1 = %p",array1);
  endfunction					
endclass


program fs_rand;
  fs_array pkt;
   initial
     begin
	  pkt=new();
	     repeat(1)
		  begin
		    pkt.randomize();
			   foreach(pkt.array1[i])
			     foreach(pkt.array1[i][j])
				    begin
					  pkt.array1[i][j]=i+j;
					  $display("array [%0d][%0d]=%0d",i,j,pkt.array1[i][j]);
					end
			pkt.display();
					
		  end
	 end
endprogram*/



//----3)Write a constraint to generate the below pattern in dynamic array ?
//---0 1 0 2 0 3 0 4 0 5 0 

/*module even();
  class eve;
    rand bit[7:0] a[];   
	
    constraint a1 { a.size inside {[7:10]};}
	
    constraint a3 {foreach(a[i])  
	                  if ( i%2 ==0) 
					    a[i] ==0; 
					  else 
					    a[i] == (i+1)/2;}
    
  endclass
  
  initial 
    begin
      eve p1=new;
      repeat(5)
        begin 
          assert(p1.randomize());
        foreach(p1.a[i])
          $display( " [%0d]  %0d  " ,i , p1.a[i]);
          $display(" %p %0d ", p1,p1.a.sum());
    end
    end
endmodule*/


/*

//4)---Pre Post Randomization examples

class abc;
   reg [5:0] i;
   function void pre_randomize();
         $display("entered pre randomize");
   endfunction
    function void post_randomize();
	    $display("post randomize");
	 endfunction

endclass


module mod;
  abc pkt;
  initial
    begin
	  pkt=new();
	  pkt.pre_randomize();
	  pkt.post_randomize();
	end


endmodule*/

/*

//--5)write a constraint to randmoly genrate 10 unquie numbers between 99 to 100

  class eve;
    rand int a;
     real re_num;
    
    constraint a1 { a inside {[990:1000]};}
    function void post_randomize();
      re_num = a/10.0;
      $display(" the rela num %2f", re_num);              
    endfunction 
  endclass

module factorial(); 
  initial 
    begin
      eve p1=new;
      repeat(10) 
        begin
       assert(p1.randomize());
          $display("randomize---a---value is %p ", p1.a);
        end 
    end
endmodule*/

//---6)Write constraint to generate random values 25,27,30,36,40,45 without using "set membership". 

class cls;
  rand bit [5:0] v;
  
  //constraint abc {v inside{25,27,30,36,40,45};}
 constraint range {v>24;v<46;
                   (v%9==0)||(v%5==0);
				    v!=35;}
  
endclass


module mod;
 cls pkt;
 initial
   begin
     pkt=new();
	   repeat(10)
	     begin
		  pkt.randomize();
		  $display("value is v=%0d",pkt.v);
		 end
   end
endmodule