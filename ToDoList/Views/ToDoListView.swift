import SwiftUI
import FirebaseFirestoreSwift

struct ToDoListView: View {
    @StateObject var viewModel = ToDoListViewModel()
    @FirestoreQuery var items : [ToDoListItem]
    
    private let userId: String
    init(userId: String) {
        self.userId = userId
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")
    }
    var body: some View {
        NavigationView{
            VStack {
                List(items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.title2)
                            Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated,time: .shortened))")
                                .font(.footnote)
                                .foregroundColor(Color(.secondaryLabel))
                        }
                        
                        Spacer()
                        
                        Button {
                            viewModel.toggleIsCheck(item: item, userId: userId)
                        } label: {
                            Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(Color.blue)
                        }
                    }
                    .swipeActions {
                        Button {
                            viewModel.deleteItem(itemId: item.id, userId: userId)
                        } label: {
                            Label("Delete", systemImage: "trash")
                                .tint(Color.red)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("To Do List")
            .toolbar{
                Button {
                    viewModel.isShowing = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.isShowing){
                NewItemView(newItemPresented: $viewModel.isShowing)
            }
        }
    }
}

#Preview {
    ToDoListView(userId: "45SPHX01rbRij87CY0PCUCvPqJp2")
}
