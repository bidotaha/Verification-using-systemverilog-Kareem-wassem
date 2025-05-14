package my_package;
  parameter HEIGHT = 10;
  parameter WIDTH = 10;
  parameter PERCENT_WHITE = 20;

  typedef enum  { BLACK , WHITE } colors_t;

  class screen;
   
   rand  colors_t array_pixel [HEIGHT] [WIDTH];

    constraint colors_c {
        foreach (array_pixel [i,j]) {
         array_pixel [i] [j] dist {
         WHITE := PERCENT_WHITE,
         BLACK := 100 - PERCENT_WHITE};
          }
    };
 
    function void print_screen () ;
        foreach (array_pixel[i])
        $display("array %d = %p",i,array_pixel[i]);
        
    endfunction


  endclass 

    
endpackage