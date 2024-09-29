package algo;

public class WaterBottle {
    String[] colors;
    int capacity;
    boolean isSameColor;
    int id;
    int top_color_idx;

    public WaterBottle(String color_str, int capacity, int id){
        this.colors = color_str.split(",");
        this.capacity = capacity;
        this.top_color_idx = this.lastColorIdx();
        this.isSameColor = this.checkSameColor();
        this.id = id;
    }

    public WaterBottle(WaterBottle wb){
        this.colors = wb.colors.clone();
        this.capacity = wb.capacity;
        this.top_color_idx = wb.top_color_idx;
        this.isSameColor = wb.isSameColor;
        this.id = wb.id;
    }
/*
     t       b
    "e,e,b,y,r"
    e,e,e,e,e

 */
    public boolean checkSameColor(){
        String bottom_color = this.colors[this.colors.length-1];
        for(int i=this.colors.length-2;i>=this.top_color_idx;i--){
            String curr_color = this.colors[i];
            if(!curr_color.equals(bottom_color) && !curr_color.equals("e")){
                return false;
            }
        }
        return true;
    }

    public int lastColorIdx(){
        int i = this.colors.length - 1;
        for(; i >= 0; i--){
            if (this.colors[i].equals("e"))
                return i + 1;
        }
        if(i==-1) return 0;
        return this.capacity;
    }

    public String getLastColor(){
        if(this.top_color_idx == this.capacity){
            return "e";
        }
        return this.colors[this.top_color_idx];
    }

    public boolean insertColor(String color){
        if (this.isFull()) {
            return false;
        }
        this.top_color_idx -= 1;
        this.colors[this.top_color_idx] = color;
        this.isSameColor = this.isSameColor && color.charAt(0) == this.colors[this.colors.length - 1].charAt(0);
        return true;
    }

    public String removeColor(){
        if(this.top_color_idx==this.capacity) {
            return "e";
        }
        String res=this.colors[this.top_color_idx];
        this.colors[this.top_color_idx]="e";
        this.top_color_idx++;
        this.isSameColor = this.checkSameColor();
        return res;
    }

    public boolean isEmpty(){
        return this.getLastColor().equals("e");
    }

    public boolean isFull(){
        return !this.colors[0].equals("e");
    }
    public boolean isInsertable(WaterBottle wb2){
//        System.out.println(this.isEmpty()+" "+ this.getLastColor().equals(wb2.getLastColor())+ " "+ wb2.isEmpty()+ " wb1 last color: "+this.getLastColor()+" wb2 last color: "+wb2.getLastColor());
        return !this.isEmpty() && ((this.getLastColor().equals(wb2.getLastColor()) && !wb2.isFull()) || (wb2.isEmpty()));
    }


    public WaterBottle clone(){
        return new WaterBottle(this);
    }

    public String toString(){
        return "Bottle id: "+ this.id + "; "+ String.join(",", this.colors);
    }

    public int getNumberOfDifferentColors(){
        HashSet<String> colors = new HashSet<>();
        int count = 0;
        for(String color: this.colors){
            if(!color.equals("e") && !colors.contains(color)){
                colors.add(color);
                count++;
            }
        }
        return count;
    }
}
