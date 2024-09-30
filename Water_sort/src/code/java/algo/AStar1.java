package algo;

public class AStar1 extends AStar{
    @Override
    public int heuristic(WaterBottle[] waterBottles) {
        // return the number of different colors in the bottle with the most different colors
        int max_diff_layers = 1;
        for (WaterBottle waterBottle : waterBottles) {
            max_diff_layers = Math.max(max_diff_layers, waterBottle.getNumberOfDifferentColors());
        }
        return max_diff_layers - 1;
    }

//    just trying out other heuristic
//    @Override
//    public int heuristic(WaterBottle[] waterBottles) {
//        // return the number of different colors in the bottle with the least different colors
//        int min_diff_layers = Integer.MAX_VALUE;
//        for (WaterBottle waterBottle : waterBottles) {
//            if(!waterBottle.isSameColor){
//                min_diff_layers = Math.min(min_diff_layers, waterBottle.getNumberOfDifferentColors());
//            }
//        }
//        if(min_diff_layers==Integer.MAX_VALUE) return 0;
//        return min_diff_layers - 1;
//    }
}
