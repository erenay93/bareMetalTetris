#include "screen.h"
void print_char(char character, int col, int row, char attribute){
    unsigned char *vidmem = (unsigned char *) VIDEO_ADDRESS;

    if(!attribute){
        attribute = WHITE_ON_BLACK;
    }

    int offset;
    if (col >= 0 && row >= 0) {
        offset = get_screen_offset(col, row);
    }else {
        offset = get_cursor(); 
    }

    if (character == '\n') {
        int rows = offset / (2* MAX_COLS );
        offset = get_screen_offset(79, rows);
    }else {
        vidmem[offset] = character;
        vidmem[offset+1] = attribute; 
    }

    offset += 2;
    offset = handle_scrolling(offset);
    set_cursor(offset);
}


void print_at(char* message, int col, int row) {
// Update the cursor if col and row not negative. 
if (col >= 0 && row >= 0) {
set_cursor(get_screen_offset(col, row)); }
// Loop through each char of the message and print it. 
int i = 0;
while(message[i] != 0) {
print_char(message[i++], col, row, WHITE_ON_BLACK); }
}