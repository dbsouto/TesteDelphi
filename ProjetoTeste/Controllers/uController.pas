unit uController;

interface

uses System.Generics.Collections;

type
  IController<T> = Interface
  ['{D0602AC6-5A5A-4DD7-9EE9-05E9B96C054C}']
    function Select(Objeto: T): TEnumerable<T>;
    procedure Insert(Objeto: TEnumerable<T>);
    procedure Update(Objeto: TEnumerable<T>);
    procedure Delete(Objeto: TEnumerable<T>);
  End;

implementation

end.
