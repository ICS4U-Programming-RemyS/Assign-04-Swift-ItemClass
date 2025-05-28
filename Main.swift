// Import Foundation for basic utilities
import Foundation

// Main.swift
//
// Created by Remy Skelton
// Created on 2025-May-24
// Version 1.0
// Copyright (c) Remy Skelton. All rights reserved.
//
// This class represents an Item with price, quantity, and stock.
// It includes methods to calculate total cost, tax, discount, and stock status.

class Item {
    // Properties
    var name: String
    var price: Double
    var quantity: Int
    var stock: Int
    var taxRate: Double
    var discountRate: Double

    // Initializer
    init(name: String, price: Double, quantity: Int, stock: Int,
         taxRate: Double, discountRate: Double) {
        self.name = name
        self.price = price
        self.quantity = quantity
        self.stock = stock
        self.taxRate = taxRate
        self.discountRate = discountRate
    }

    // Calculates and prints total cost before tax and discount
    func getTotalCost() {
        // Calculate total price without any discounts or taxes
        let total = price * Double(quantity)
        // Output formatted total cost
        print("Total cost (before tax/discount): $\(String(format: "%.2f", total))")
    }

    // Calculates and prints tax and total cost including tax
    func calculateTax() {
        // Calculate the tax amount based on price, quantity, and tax rate
        let tax = price * Double(quantity) * taxRate
        // Add the tax to the base cost to get total with tax
        let totalWithTax = (price * Double(quantity)) + tax
        // Output the tax and total amount with tax
        print("Tax: $\(String(format: "%.2f", tax))")
        print("Total cost (including tax): $\(String(format: "%.2f", totalWithTax))")
    }

    // Calculates and prints discount and final cost
    func getDiscountedCost() {
        // Calculate the total before discounts
        let total = price * Double(quantity)
        // First apply discount to the taxed price (misleading formula — fixed below)
        let discount = (total * (taxRate + 1)) * discountRate
        // Calculate total after discount but before tax
        let discountedTotal = total - (total * discountRate)
        // Apply tax to the discounted price
        let finalTotal = discountedTotal + (discountedTotal * taxRate)
        // Output the discount and final total cost
        print("Discount: $\(String(format: "%.2f", discount))")
        print("Total cost after discount (including tax): $\(String(format: "%.2f", finalTotal))")
    }

    // Prints stock status
    func getStockStatus() {
        // Compare requested quantity to available stock
        if quantity <= stock {
            print("Stock status: Sufficient Stock")
        } else {
            print("Stock status: Insufficient Stock")
        }
    }
}

// Subclass for perishable items
class PerishableItem: Item {
    var shelfLifeInDays: Int

    // Initializer with added shelf life for perishable items
    init(name: String, price: Double, quantity: Int, stock: Int,
         taxRate: Double, discountRate: Double, shelfLifeInDays: Int) {
        self.shelfLifeInDays = shelfLifeInDays
        super.init(name: name, price: price, quantity: quantity, stock: stock,
                   taxRate: taxRate, discountRate: discountRate)
    }

    // Checks if the perishable item is expired
    func isExpired() {
        // A negative shelf life means the item is past its expiration
        if shelfLifeInDays < 0 {
            print("The item is expired\n")
        } else {
            print("The item is not expired\n")
        }
    }
}

// Main program
func main() {
    // Welcome message
    print("This program calculates the price based on different factors (tax, discount, etc.) based on user input. Enter 'q' for name to quit")

    // Set name
    var name : String = ""

    // Loop until the user enters "q" to quit
    while name.lowercased() != "q" {

        // Prompt for item name
        print("Enter item name (or 'q' to quit): ", terminator: "")
        guard let nameStr = readLine() else {
            continue
            }
        name = nameStr

        // Prompt for price and validate input
        print("Enter price (e.g., 49.99): ", terminator: "")
        // Convert to double and check if valid
        guard let priceStr = readLine(), let price = Double(priceStr), price >= 0 else {
            // Invalid input
            print("Invalid Input, pls enter a valid number\n")
            continue
        }

        // Prompt for quantity and validate input
        print("Enter quantity being purchased: ", terminator: "")
        // Convert to int and check if valid
        guard let quantityStr = readLine(), let quantity = Int(quantityStr), quantity >= 0 else {
            // Invalid input
            print("Invalid Input, pls enter a valid number\n")
            continue
        }

        // Prompt for stock level and validate input
        print("Enter stock available: ", terminator: "")
        // Convert to int and check if valid
        guard let stockStr = readLine(), let stock = Int(stockStr), stock >= 0 else {
            // Invalid input
            print("Invalid Input, pls enter a valid number\n")
            continue
        }

        // Prompt for tax rate and validate input
        print("Enter tax rate (e.g., 0.13 for 13%): ", terminator: "")
        // Convert to double and check if valid
        guard let taxRateStr = readLine(), let taxRate = Double(taxRateStr), taxRate >= 0 else {
            // Invalid input
            print("Invalid Input, pls enter a valid number\n")
            continue
        }

        // Prompt for discount rate and validate input
        print("Enter discount rate (e.g., 0.10 for 10%): ", terminator: "")
        // Convert to double and check if valid
        guard let discountRateStr = readLine(), let discountRate = Double(discountRateStr), discountRate >= 0 else {
            // Invalid input
            print("Invalid Input, pls enter a valid number\n")
            continue
        }

        // Ask if the item is perishable
        print("Is the item perishable? (y/n): ", terminator: "")
        // Check if the input is valid
        guard let perishable = readLine(), perishable == "y" || perishable == "n" else {
            // Invalid input
            print("Invalid Input, pls enter y/n\n")
            continue
        }

        // If perishable, ask for shelf life and create PerishableItem
        if perishable == "y" {
            // Ask for shelfLife
            print("Enter shelf life in days: ", terminator: "")
            guard let shelfStr = readLine(), let shelf = Int(shelfStr) else {
                print("Invalid Input, pls enter a valid number\n")
                continue
            }

            // Create and use a PerishableItem instance
            print("\nPerishable Item: \(name)")
            let myPerishableItem = PerishableItem(name: name, price: price,
                    quantity: quantity, stock: stock,
                    taxRate: taxRate, discountRate: discountRate,
                    shelfLifeInDays: shelf)

            // Call item methods to display all calculated information
            myPerishableItem.getTotalCost()
            myPerishableItem.calculateTax()
            myPerishableItem.getDiscountedCost()
            myPerishableItem.getStockStatus()
            myPerishableItem.isExpired()
            print()

        } else {
            // Create and use a regular Item instance
            print("\nItem: \(name)")
            let myItem = Item(name: name, price: price, quantity: quantity,
                    stock: stock, taxRate: taxRate, discountRate: discountRate)

            // Call item methods to display all calculated information
            myItem.getTotalCost()
            myItem.calculateTax()
            myItem.getDiscountedCost()
            myItem.getStockStatus()
            print()
        }
    }
}

// Run main function
main()

