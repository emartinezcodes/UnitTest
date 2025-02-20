package myFirstProject;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class MathUtilsTest {
	
	private MathUtils mathUtils;
	
	@BeforeEach
    void setUp() {
        // Initialize MathUtils before each test
        mathUtils = new MathUtils();
    }

	 
	@Test
	void testAdd() {
		assertEquals(7, mathUtils.add(4, 3), "Answer is 7");
        assertEquals(0, mathUtils.add(-3, 3), "Answer is 0");
        assertEquals(-14, mathUtils.add(-9, -5), "answer is -14");
	}

	@Test
	void testSubtract() {
		assertEquals(1, mathUtils.subtract(6, 5));
        assertEquals(-4, mathUtils.subtract(-3, 1));
        assertEquals(17, mathUtils.subtract(22, 5) );
	}

	@Test
	void testMultiply() {
		assertEquals(36, mathUtils.multiply(6, 6));
        assertEquals(0, mathUtils.multiply(1000, 0));
        assertEquals(-64, mathUtils.multiply(-8, 8));
	}

	@Test
	void testDivide() {
		assertEquals(4.0, mathUtils.divide(8, 2), 0.0001);
        assertEquals(-1.0, mathUtils.divide(5, 0), 0.0001);
        assertEquals(7.5, mathUtils.divide(15, 2), 0.0001);
	}

}
