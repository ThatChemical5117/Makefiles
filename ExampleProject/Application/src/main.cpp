#include "MathLibrary.h"
#include <iostream>

int main()
{
	std::cout << "12 + -3.1" << std::endl;
    double additionResult = MathLibrary::Arithmetic::Add(12, -3.1);
    std::cout << "Result of addition: " << additionResult << std::endl;

	std::cout << "-2.13 - 14" << std::endl;
    double subtractionResult = MathLibrary::Arithmetic::Subtract(-2.13, 14);
    std::cout << "Result of subtraction: " << subtractionResult << std::endl;
}
