require "todo/entities/todo"

module Todo::Entities
  describe Todo do
    context "todo has a description" do
      let(:description) { "description" }

      it "equals another entity with the same description" do
        expect(make_todo(description)).to eq make_todo(description)
      end

      it "does not equal another entity with a different description" do
        expect(make_todo(description)).not_to eq make_todo(description + "diff")
      end

      it "equals itself" do
        todo = make_todo(description)
        expect(todo).to eq(todo)
      end
    end

    context "todo has nil description" do
      it "does not equal another entity with no description" do
        expect(make_todo(nil)).not_to eq make_todo(nil)
      end

      it "does not equal an entity with a description" do
        expect(make_todo(nil)).not_to eq make_todo("foo")
      end

      it "equals itself" do
        todo = make_todo(nil)
        expect(todo).to eq(todo)
      end
    end

    def make_todo(description)
      Todo.new(description: description)
    end
  end
end
