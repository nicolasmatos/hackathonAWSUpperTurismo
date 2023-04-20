CREATE TABLE [dbo].[postcards] (
    [Id]        INT            IDENTITY (1, 1) NOT NULL PRIMARY KEY CLUSTERED ([Id] ASC),
    [id_uf]     INT            NOT NULL,
    [cidade]    NVARCHAR (MAX) NOT NULL,
    [card]      NVARCHAR (MAX) NOT NULL,
    [descricao] NVARCHAR (MAX) NOT NULL,
    CONSTRAINT [FK_postcards_capas] FOREIGN KEY ([id_uf]) REFERENCES [dbo].[capas] ([Id])
);
