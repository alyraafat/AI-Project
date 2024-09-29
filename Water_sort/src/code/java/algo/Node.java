package algo;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Objects;
import java.util.function.BiFunction;
import java.util.function.Function;

public class Node {
    Node parent;
    int cost;
    int depth;
    String operator;
    WaterBottle[] waterBottles;
    String path;


    public Node(Node parent, int cost, int depth, String operator, WaterBottle[] waterBottles){
        this.parent = parent;
        this.cost = cost;
        this.depth = depth;
        this.operator = operator;
        this.waterBottles = waterBottles;
        this.path = parent == null ? "" : (parent.path.isEmpty() ? this.operator: parent.path + "," + this.operator);
    }

    public ArrayList<Node> get_children(BiFunction<Integer, WaterBottle[], Integer> evalFunc){
        ArrayList<Node> res = new ArrayList<>();
        for(int i=0;i<this.waterBottles.length;i++){
            WaterBottle wb1 = this.waterBottles[i];
//            System.out.println("get children");
            for(int j=i+1;j<this.waterBottles.length;j++){
//                System.out.println("get children inner");
                WaterBottle wb2 = this.waterBottles[j];
//                System.out.println("Node one");
                Node one = this.get_child(wb1, wb2, i, j, evalFunc);
//                System.out.println("Node two");
                Node two = this.get_child(wb2, wb1, j, i, evalFunc);
                if (one != null) res.add(one);
                if (two != null) res.add(two);
            }
        }
//        System.out.println(res);
        return res;
    }

    public Node get_child(WaterBottle wb1, WaterBottle wb2, int i, int j, BiFunction<Integer, WaterBottle[], Integer> evalFunc){
        int layersPoured = 0;
        WaterBottle wb1_temp = wb1.clone();
        WaterBottle wb2_temp = wb2.clone();
        String operator = "pour_"+wb1.id+"_"+wb2.id;
//        System.out.println(operator);
        while (wb1_temp.isInsertable(wb2_temp)) {
//            System.out.println("isInsertable");
//            System.out.println(wb1_temp+"--"+wb2_temp);
            WaterBottle[] waterBottles = this.pour(wb1_temp, wb2_temp);
            wb1_temp = waterBottles[0];
            wb2_temp = waterBottles[1];
            layersPoured++;
        }
        if(layersPoured>0){
            WaterBottle[] newWaterBottles = this.waterBottles.clone();
            newWaterBottles[i] = wb1_temp;
            newWaterBottles[j] = wb2_temp;
            int addedCost = evalFunc.apply(layersPoured, newWaterBottles);
            return new Node(this, this.cost+addedCost, this.depth+1, operator, newWaterBottles);
        }
        return null;
    }


    public WaterBottle[] pour(WaterBottle wb1, WaterBottle wb2){
        WaterBottle[] wbs = new WaterBottle[2];
        WaterBottle wb1_copy = wb1.clone();
        String removed_color = wb1_copy.removeColor();
        WaterBottle wb2_copy = wb2.clone();
        boolean isInserted = wb2_copy.insertColor(removed_color);
        wbs[0] = wb1_copy;
        wbs[1] = wb2_copy;
//        System.out.println("In pour: "+wb1_copy+"---"+wb2_copy+"////"+"removed_color: "+removed_color+"///isInserted:"+isInserted);
        return wbs;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true; // Check reference equality
        if (o == null || getClass() != o.getClass()) return false; // Check class type
        Node node = (Node) o;
        return node.toString().equals(this.toString()); // Check equality based on attributes
    }

    // Override hashCode method to provide consistent hash codes for equal objects
    @Override
    public int hashCode() {
        return Objects.hash(this.toString()); // Generate hash code based on attributes
    }
    @Override
    public String toString(){
        StringBuilder res = new StringBuilder();
        for (WaterBottle wb: waterBottles) {
            res.append(wb).append(";");
        }
        return res.toString();
    }
}
