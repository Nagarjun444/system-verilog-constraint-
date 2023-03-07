/*class abc;
 rand bit [31:0]var1;
 rand bit [3:0]c1;
     
 
   //constraint c11{c1==1<<var1;}
 // constraint c2{$onehot(c1)==1;}
 //constraint c2{$countones(c1)==1;}
 constraint c3{(c1&(c1-1))==0;c1!=0;}
endclass

module bb();
abc ab_h;
initial
 begin
 ab_h=new();
 repeat(10)
  begin
   ab_h.randomize();
  $display("values are %0d and %0b",ab_h.c1,ab_h.c1);
  end
 end
endmodule*/

/*
class eve;
 rand bit[6:0]a[];
 constraint a1{a.size inside {[5:10]};}
 //constraint a2{foreach(a[i]) if (i>0) a[i]<a[i-1];}//value of decending order
 constraint a3{foreach(a[i]) if (i>0) a[i]>a[i-1];}//value of ascending order
 
endclass



module eveno;
initial
 begin
 eve p1=new();
 repeat(1)
  begin
    assert(p1.randomize());
    foreach(p1.a[i])
     $display("[%0d] %0d",i,p1.a[i]);	
     $display("%p %0d",p1,p1.a.sum());
  end	 
end

endmodule
*/

/*
class packet;
rand bit [5:0] array[];
randc int c;


constraint size_array{c inside {[4:20]}; array.size==c;}
constraint elements{foreach(array[i]) array[i] inside {[0:64]};}
constraint abc {foreach(array[i]) foreach(array[j]) if (i!=j) array[i]!=array[j];}
endclass


module foreach_const;
packet pkt = new;
  initial
   begin
     repeat(10)
	 begin
	  assert(pkt.randomize());
	  $display("the size of the array=%0d",pkt.array.size());
	  $display("the size of the array=%p",pkt.array);
	 end  
   end
endmodule*/


//7)write a constraint to generate a variable with 0-31 bits should be 1,32-61 bits should be 0.
class abc;
rand bit [61:0] num;
constraint no{foreach(num[i])
               if(i>=0&&i<32)
			       num[i]==1'b1;
				else if(i>31&&i<62)
               	num[i]==1'b0;}
function void post_randomize();
$display("num=%0d num=%0b",num,num);
endfunction
endclass


module test;

abc abc1;
initial
 begin
 abc1=new();
 abc1.randomize();
 end


endmodule







/*class abc;
 rand bit [31:0]var1;
 rand bit [3:0]c1;
     
 
   //constraint c11{c1==1<<var1;}
 // constraint c2{$onehot(c1)==1;}
 //constraint c2{$countones(c1)==1;}
 constraint c3{(c1&(c1-1))==0;c1!=0;}
endclass

module bb();
abc ab_h;
initial
 begin
 ab_h=new();
 repeat(10)
  begin
   ab_h.randomize();
  $display("values are %0d and %0b",ab_h.c1,ab_h.c1);
  end
 end
endmodule*/





/*
class eve;
 rand bit[6:0]a[];
 constraint a1{a.size inside {[5:10]};}
 //constraint a2{foreach(a[i]) if (i>0) a[i]<a[i-1];}//value of decending order
 constraint a3{foreach(a[i]) if (i>0) a[i]>a[i-1];}//value of ascending order
 
endclass



module eveno;
initial
 begin
 eve p1=new();
 repeat(1)
  begin
    assert(p1.randomize());
    foreach(p1.a[i])
     $display("[%0d] %0d",i,p1.a[i]);	
     $display("%p %0d",p1,p1.a.sum());
  end	 
end

endmodule
*/




/*
class packet;
rand bit [5:0] array[];
randc int c;


constraint size_array{c inside {[4:20]}; array.size==c;}
constraint elements{foreach(array[i]) array[i] inside {[0:64]};}
constraint abc {foreach(array[i]) foreach(array[j]) if (i!=j) array[i]!=array[j];}
endclass


module foreach_const;
packet pkt = new;
  initial
   begin
     repeat(10)
	 begin
	  assert(pkt.randomize());
	  $display("the size of the array=%0d",pkt.array.size());
	  $display("the size of the array=%p",pkt.array);
	 end  
   end
endmodule*/

/*
//7)write a constraint to generate a variable with 0-31 bits should be 1,32-61 bits should be 0.
class abc;
rand bit [61:0] num;
constraint no{foreach(num[i])
               if(i>=0&&i<32)
			       num[i]==1'b1;
				else if(i>31&&i<62)
               	num[i]==1'b0;}
				
function void post_randomize();
$display("num=%0d num=%0b",num,num);
endfunction
endclass


module test;

abc abc1;
initial
 begin
 abc1=new();
 repeat(2)
 begin
 abc1.randomize();
 end
 end


endmodule

//8)if we randomize a single bit variable for 10 times values should generate be like 101010101010.

class abc;
rand bit a;
static bit b=0;

constraint no{a!=b;}

function void post_randomize();
$display("a=%0b,b=%0b",a,b);
b=a;
endfunction

endclass


module nag;
abc nag;
initial
begin
nag=new();
repeat(10)
begin
nag.randomize();
end
end
endmodule*/


//9)we have a randomize variable with size of 32 bit data,but randomize only 12th bit.



class nag;
  randc bit [31:0]a;
  constraint no{foreach(a[i])
                if(i==12)
				 a[i] inside {0,1};
				else
				a[i] == 0;}
				
				
function void post_randomize();
$display("a=%0d a=%0b",a,a);
endfunction				

endclass

module mod;
nag abc;
initial
begin
  abc=new();
   repeat(10)
    begin
      abc.randomize();
    end
end
endmodule



// A simple pattern generation using constraints

class day26 #(parameter N = 4);

  randc bit [N-1:0] pattern;
        bit [N-1:0] num_ones;

  function void pre_randomize();
    if (num_ones < N)
         num_ones++;
	else
         num_ones = 1;
  endfunction

  constraint gen_pattern 
  {foreach (pattern[i]) 
       {
      if (i < num_ones)
     	 pattern[N-1-i] == 1;
      else            
	    pattern[N-1-i] == 0;
    }
  };

endclass
    
// Construct the class in the TB

module day26_tb ();

  day26 #(.N(8))  byte_pattern;
  day26 #(.N(32)) word_pattern;

 initial
  begin
    byte_pattern = new();
    word_pattern = new();
    repeat (8)
   	 begin
      byte_pattern.randomize();
      $display("%d\n", byte_pattern.pattern);
     end

    repeat (32) 
	begin
      word_pattern.randomize();
      $display("%d\n", word_pattern.pattern);
    end
  end

endmodule 


module even();
  class eve;
    rand bit[6:0] a[];
 
    
    constraint a1 { a.size inside {[5:10]};}
   // constraint a2 {foreach(a[i])  if (i>0) a[i]<a[i-1];}   // vlaues of decending order  
    constraint a3 {foreach(a[i])  if (i>0) a[i]>a[i-1];}  // vlaues of ascending order 
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
endmodule




/*class constrain;

rand bit [10:0] abc;
rand bit [10:0] data;

constraint contraint{abc dist{3:=3};}
constraint contraint1{data dist{[5:9]:=5};}

endclass


module example;

constrain cons;

initial
 begin
	  cons =new();
	  repeat(10)
   begin
	  cons.randomize();
	  $display("cons abc  =%0d",cons.abc);
	  $display("cons data =%0d",cons.data);
   end
 end
endmodule

*/


    class c1;

        rand int A[]; //dynamic array


        //specify array size
        constraint c1 { A.size inside {[8:10]};}


        //generage a unique array
        constraint c2 {unique {A};}


        //sort the array using array method
        function void post_randomize ();
            A.sort();
        endfunction

    endclass


program p1;


   

    c1 c1_h;


    initial begin

        c1_h = new();

        repeat(3) begin
            if(c1_h.randomize())
                $display("A is %p",c1_h.A);
        end

    end

endprogram



class insideconstraint;
 rand bit [10:0] address;
 rand bit [10:0] data;
 
 constraint name1 {address inside{[5:10]};}
// constraint name2 {data    inside{[5:10]};}
 constraint name2 {data inside{1,2,5,7,9};}
  task display;
     begin
	  $display("address=%0d",address);
	  $display("data=%0d",data);
	 end  
  endtask
endclass


program prog;
  insideconstraint  cons;
  initial
   begin
     cons=new();
	 repeat(10)
	 begin
	 cons.randomize();
	 cons.display();
	 end
   end
endprogram