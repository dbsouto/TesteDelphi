unit uController;

interface

uses Contnrs;

type
  IController<T> = Interface
  ['{D0602AC6-5A5A-4DD7-9EE9-05E9B96C054C}']
    procedure Delete(Objeto: T);
    procedure Insert(Objeto: T);
    function Select(Objeto: T): TObjectList;
    function Update(Objeto: T): T;
  End;

implementation

end.
