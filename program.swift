import SwiftUI

struct Expense: Identifiable {
    let id = UUID(), title: String, amount: Double
}

@main
struct ExpenseTrackerApp: App {
    @State private var expenses: [Expense] = []
    @State private var title = ""
    @State private var amount = ""

    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    List {
                        Text("Total: $\(expenses.reduce(0){ $0 + $1.amount }, specifier: "%.2f")").font(.headline)
                        ForEach(expenses) { Text("\($0.title): $\($0.amount, specifier: "%.2f")") }
                            .onDelete { expenses.remove(atOffsets: $0) }
                    }.navigationTitle("Expenses")
                }.tabItem { Label("List", systemImage: "list.bullet") }

                NavigationView {
                    Form {
                        TextField("Title", text: $title)
                        TextField("Amount", text: $amount).keyboardType(.decimalPad)
                        Button("Add") {
                            if let val = Double(amount), !title.isEmpty {
                                expenses.append(Expense(title: title, amount: val))
                                title = ""; amount = ""
                            }
                        }
                    }.navigationTitle("Add Expense")
                }.tabItem { Label("Add", systemImage: "plus") }
            }
        }
    }
}
