CREATE TABLE [dbo].[capas] (
    [Id]      INT            IDENTITY (1, 1) NOT NULL PRIMARY KEY CLUSTERED ([Id] ASC),
    [uf]      NVARCHAR (MAX) NOT NULL,
    [estado]   NVARCHAR (MAX) NOT NULL,
    [musica]   NVARCHAR (MAX) NOT NULL,
    [youtube] NVARCHAR (MAX) NOT NULL,
    [imagem]   NVARCHAR (MAX) NOT NULL
);
