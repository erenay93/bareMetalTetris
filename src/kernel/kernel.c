#include "low_level.c"
void putpixel(int pos_x, int pos_y, unsigned char VGA_COLOR)
{
    unsigned char* location = (unsigned char*)0xA0000 + 320 * pos_y + pos_x;
    *location = VGA_COLOR;
}
void draw_rect(int pos_x, int pos_y, int width, int height, int thickness, unsigned char color){
    for(int j = 0; j < thickness; j++){
        for(int i = pos_x+j; i <= (pos_x+width-j); i++){
            putpixel(i,pos_y+j,color);
            putpixel(i,pos_y+height-j,color);
        }
        for(int k = pos_y+j; k <= (pos_y+height-j); k++){
            putpixel(pos_x+j,k,color);
            putpixel(pos_x+width-j,k,color);
        }
    }
}
void main(){
    //char* videoMem = 0xb8000;
    //for(int row = 0; row<25;row++){
    //    for(int col = 0; col < 160; col=col+2){
    //        videoMem[(row*160)+col] = '#';
    //        videoMem[(row*160)+col+1] = 0x02;
    //    }
    //}


    //port_word_out(0x3d4,0x000C);
    //port_word_out(0x3d4,0x0012);
    draw_rect(10,10,50,50,3,0x2);
    draw_rect(13,13,44,44,3,0x3);
    draw_rect(16,16,38,38,3,0x4);
    putpixel(0,0,4);
    
}